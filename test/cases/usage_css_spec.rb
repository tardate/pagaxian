require 'spec_helper'

class UsageCssSpec < Pagaxian::Spec

  describe 'application.css' do

    let(:app_css) { dummy_asset('application.css') }

    it 'will render main bootstrap.less file and all included modules' do
      app_css.must_include 'pagaxian'
    end

    it 'must include basic css afterward' do
      app_css.must_include '#other-css { color: red; }',  'From our code afterward.'
    end

  end


  describe 'framework.css.less' do

    before { dummy_config.less.compress = true }

    let(:framework_css) { dummy_asset('framework.css') }

    # it 'will render ui_kit variables' do
    #   link_color_line = line_for_framework_css('framework-brand-primary')
    #   link_color_line.must_include 'color:#428bca;'
    # end

  end



  private

  def line_for_framework_css(name)
    framework_css.each_line.detect{ |line| line.include? name }.strip
  end

end
