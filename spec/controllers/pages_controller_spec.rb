require 'spec_helper'

describe PagesController do

  describe "GET 'index'" do
    it "returns http success" do
      get :index
      response.should be_success
    end
  end

  describe "GET 'projects'" do
    before do
      category = FactoryGirl.create(:category)
      @project = FactoryGirl.create(:project, :published => true)
    end

    it "returns http success" do
      get :projects
      response.should be_success
    end
  end

  describe "GET 'blog'" do
    before do
      @post = FactoryGirl.create(:post)
    end

    it "returns http success" do
      get :blog
      response.should be_success
    end
  end

end
