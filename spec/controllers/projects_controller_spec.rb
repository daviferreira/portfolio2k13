require 'spec_helper'

describe ProjectsController do
  describe "projects listing" do
    describe "GET 'index'" do
      it "returns http success" do
        category = FactoryGirl.create(:category)
        FactoryGirl.create(:project, :published => true)
        get :index
        response.should be_success
      end
    end
  end

  describe "show project" do

    describe "GET 'show'" do

      it "should return 404 when project is invalid" do
        get :show, :id => "invalid"
        response.response_code.should == 404
      end

      it "shoould find localized project" do
        pending
      end

    end

  end

end
