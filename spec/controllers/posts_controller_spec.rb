require 'spec_helper'

describe PostsController do
  render_views

  let(:user) { FactoryGirl.create(:user) }
  let(:blog_post) { FactoryGirl.create(:post) }

  context "when logged out" do
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
      get :edit, :id => blog_post
      response.should redirect_to new_user_session_path
    end

    it "should deny access to 'update'" do
      post :update, :id => blog_post, :post => blog_post
      response.should redirect_to new_user_session_path
    end

    it "should deny access to 'destroy'" do
      delete :destroy, :id => blog_post
      response.should redirect_to new_user_session_path
    end
  end

end
