require 'spec_helper'

class EngineSpec < Pagaxian::Spec

  it 'must be able to hook into a less-rails config' do
    dummy_config.less.must_be_instance_of ActiveSupport::OrderedOptions
  end

  it 'must append engines assets stylesheets to less-rails load paths' do
    dummy_config.less.paths.must_be_instance_of Array
    # dummy_config.less.paths.must_include project_design_less_path
  end

end
