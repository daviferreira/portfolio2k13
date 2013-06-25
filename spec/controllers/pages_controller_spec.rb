require 'spec_helper'

describe PagesController do

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

    end

  end


end
