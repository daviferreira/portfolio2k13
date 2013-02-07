require 'spec_helper'

describe ProjectsController do
  render_views

  let(:user) { FactoryGirl.create(:user) }
  let(:project) { FactoryGirl.create(:project, :name => "Sample Project") }

  describe "access control" do
    it "should deny access to 'index'" do
      get :index
      response.should redirect_to new_user_session_path
    end

    it "should deny access to 'new'" do
      get :new
      response.should redirect_to new_user_session_path
    end

    it "should deny access to 'create'" do
      post :create
      response.should redirect_to new_user_session_path
    end

    it "should deny access to 'edit'" do
      get :edit, :id => project 
      response.should redirect_to new_user_session_path
    end

    it "should deny access to 'update'" do
      post :update, :id => project, :project => project 
      response.should redirect_to new_user_session_path
    end

    it "should deny access to 'destroy'" do
      delete :destroy, :id => 1
      response.should redirect_to new_user_session_path
    end
  end

end
