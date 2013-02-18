require 'spec_helper'

describe PhotosController do
  render_views

  let(:user) { FactoryGirl.create(:user) }
  let(:category) { FactoryGirl.create(:category) }
  let(:project) { FactoryGirl.create(:project, :name => "Sample Project", :category => category) }
  let(:photo) { FactoryGirl.create(:photo, :project => project)}

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
      get :edit, :id => photo
      response.should redirect_to new_user_session_path
    end

    it "should deny access to 'update'" do
      post :update, :id => photo, :photo => photo
      response.should redirect_to new_user_session_path
    end

    it "should deny access to 'destroy'" do
      delete :destroy, :id => 1
      response.should redirect_to new_user_session_path
    end
  end

  context "when logged in" do

    before { sign_in user }

    describe "GET 'index'" do

      it "returns http success" do
        get :index
        response.should be_success
      end

      it "should list all the photos" do
        p1 = FactoryGirl.create(:photo, :title => "Foo bar")
        p2 = FactoryGirl.create(:photo, :title => "Baz quux")
        get :index
        response.body.should have_selector('td', :text => p1.title)
        response.body.should have_selector('td', :text => p2.title)
      end

      it "should paginate the photos" do
        pending "implement will paginate"
      end

    end

  end

end
