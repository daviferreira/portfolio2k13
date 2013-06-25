require 'spec_helper'

describe PagesHelper do
  let!(:page) { FactoryGirl.create(:page, :body => '<p>Hello world!</p>') }
  describe "render page" do
    it "should render the page html" do
      expect helper.render_page('test-page').should == '<p>Hello world!</p>'
    end

    it "should render localized version" do
      I18n.locale = :en
      page.title = "English Page"
      page.body = "<p>English page</p>"
      page.generate_slug!
      page.save
      expect helper.render_page('english-page').should == '<p>English page</p>'
    end
  end
end
