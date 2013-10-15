require 'rubygems'
require 'bundler'
Bundler.require
require 'pagaxian'
require 'minitest/autorun'
require 'minitest/spec'
require 'dummy_app/init'

module Pagaxian
  class Spec < MiniTest::Spec

    before do
      reset_caches
    end

    private

    def dummy_app
      Dummy::Application
    end

    def dummy_config
      dummy_app.config
    end

    def dummy_assets
      dummy_app.assets
    end

    def dummy_asset(name)
      dummy_assets[name].to_s.strip
    end

    def reset_caches
      dummy_assets.version = SecureRandom.hex(32)
      dummy_assets.cache.clear
    end

    def project_root
      File.expand_path File.join(File.dirname(__FILE__), '..')
    end

    # def project_design_less_path
    #   File.join project_root, 'design', 'less'
    # end

  end
end

