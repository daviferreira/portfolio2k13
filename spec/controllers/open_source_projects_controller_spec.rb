require 'spec_helper'

describe OpenSourceProjectsController do

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end

    it "should have the right metas" do
      get :index
      assigns(:meta_title).should == I18n.t('open_source_projects.meta.title')
      assigns(:meta_description).should == I18n.t('open_source_projects.meta.description')
    end
  end

end
