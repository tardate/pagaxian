# DataTable support - controller mixin
module Pagaxian::ActsAsPagedDatatable
  extend ActiveSupport::Concern

  included do
    if self <= ActionController::Base
      helper_method :datatable_data
    end
  end

  module ClassMethods

    # Class instance option getter
    # Options are not full resolved at the class level. Final resolution is done at point of use.
    # NB: cattr_accessor not used here to reserve instance paged_datatable_with implementation
    def paged_data_table_options
      @paged_data_table_options ||= {}
    end
    # Class instance option setter
    def paged_data_table_options=(value)
      @paged_data_table_options = value
    end

    # Usage:
    #
    #   paged_datatable_with sort_columns: %w(name email), search_columns: %w(name email)
    #
    #   paged_datatable_with index: {sort_columns: %w(name email), search_columns: %w(name email) }
    #
    def paged_datatable_with(options = {})
      if options.has_key?(:sort_columns)
        options = {:index => options}
      end

      options.each do |k, v|
        options[k][:sort_columns] ||= []
      end

      self.paged_data_table_options = options

      if (self <= InheritedResources::Base)
        respond_to :json, :only => options.keys
      end
    end

  end

  def collection
    return get_collection_ivar if get_collection_ivar
    set_collection_ivar(search_and_paginate(end_of_association_chain.scoped))
  end
  protected :collection

  def search_and_paginate(relation)
    relation = datatable_search_and_sort(relation, params)
    params[:iTotalDisplayRecords] = relation.length
    if (per_page = params[:iDisplayLength].to_i) > 0
      display_start = params[:iDisplayStart].to_i
      page = (display_start / per_page rescue 0) + 1 || 1
      relation = relation.page(page).per(per_page)
    end
    relation
  end
  protected :search_and_paginate


  def datatable_search_and_sort(relation, params)
    if (q = params[:sSearch]) && (search_columns = paged_data_table_options[:search_columns])
      conditions = search_columns.map{|f| { f.to_sym => /#{q}/i } }
      relation = relation.any_of(conditions)
    end
    if (sort_col = params[:iSortCol_0].to_i) && (sort_dir = params[:sSortDir_0]) && (sort_columns = paged_data_table_options[:sort_columns])
      sort_attribute = sort_columns[sort_col]
      sort_method = (sort_dir == 'desc') ? :desc : :asc
      relation = relation.send(sort_method,sort_attribute)
    end
    relation
  end
  protected :search_and_paginate

  # Returns the data table options for the specific instance and controller action.
  def paged_data_table_options
    (self.class.paged_data_table_options[(action_name||'index').to_sym]||{}).dup
  end

  def datatable_data(collection, &block)
    collection_array = collection.to_a
    return {'sEcho'=>params[:sEcho] || -1, 'iTotalRecords'=>0, 'iTotalDisplayRecords'=>0,'aaData'=>[]} unless collection_array.present?
    record_count = collection_array.size
    total_count = params[:iTotalDisplayRecords]
    aadata = collection_array.map(&block)
    {
      'sEcho' => params[:sEcho] || -1,
      'iTotalRecords' => record_count,
      'iTotalDisplayRecords' => total_count,
      'aaData' => aadata
    }
  end

end
