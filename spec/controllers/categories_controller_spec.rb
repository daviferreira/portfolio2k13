require 'spec_helper'

describe CategoriesController do
  render_views

  let(:user) { FactoryGirl.create(:user) }
  let(:category) { FactoryGirl.create(:category, :name => "Sample Project") }

  describe "access control" do
    it "should deny access to 'index'" do
      get :index
      response.should redirect_to new_user_session_path
    end
  end

  describe "as a signed-in user" do

    before { sign_in user }

    describe "GET 'index'" do

      it "returns http success" do
        get 'index'
        response.should be_success
      end

      it "should list all the categories" do
        c1 = FactoryGirl.create(:category, :name => "Foo bar")
        c2 = FactoryGirl.create(:category, :name => "Baz quux")
        get 'index'
        response.body.should have_selector('td', :text => c1.name)
        response.body.should have_selector('td', :text => c2.name)
      end

      it "should paginate the categories" do
        pending "implement will paginate"
      end

    end

  end

end
