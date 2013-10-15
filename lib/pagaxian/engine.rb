require 'rails'

module Pagaxian
  class Engine < ::Rails::Engine

    initializer 'pagaxian.setup', :after => 'pagaxian.after.load_config_initializers', :group => :all do |app|
    end

  end
end
