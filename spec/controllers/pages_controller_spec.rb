require 'spec_helper'

describe PagesController do

  after { I18n.locale = I18n.default_locale }

  describe "GET 'index'" do
    it "should return http success" do
      get :index
      response.should be_success
    end
  end

  describe "show page" do

    let!(:page) { FactoryGirl.create(:page) }

    describe "GET 'show'" do

      it "should return 404 when page is invalid" do
        get :show, :id => "invalid"
        response.response_code.should == 404
      end

      it "should return http success" do
        get :show, :id => page
        response.should be_success
      end

      it "should find localized page" do
        I18n.locale = :en
        page.title = "Test page"
        page.body = "test page"
        page.generate_slug!
        page.save
        get :show, { :id => page, :locale => I18n.locale }
        response.should be_success
      end

      it "should have an empty sidebar when page does not exists" do
        get :show, :id => page
        assigns(:page_sidebar).should be_empty
      end

      it "should show sidebar body when it exists" do
        sidebar = FactoryGirl.create(:page, :title => "Sidebar Test Page",
                                            :body => "sidebar")
        get :show, :id => page
        assigns(:page_sidebar).should == "sidebar"
      end

    end

  end


end
