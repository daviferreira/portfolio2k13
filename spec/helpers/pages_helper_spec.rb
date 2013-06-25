require 'spec_helper'

describe PagesHelper do
  let!(:page) { FactoryGirl.create(:page, :body => '<p>Hello world!</p>') }
  describe "render page" do
    it "should render the page html" do
      expect helper.render_page('test-page').should == '<p>Hello world!</p>'
    end
  end
end
