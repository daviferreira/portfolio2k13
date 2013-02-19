require 'spec_helper'

describe CategoriesController do
  render_views

  let(:user) { FactoryGirl.create(:user) }
  let(:category) { FactoryGirl.create(:category, :name => "Sample Category") }

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
      get :edit, :id => category
      response.should redirect_to new_user_session_path
    end

    it "should deny access to 'update'" do
      post :update, :id => category, :category => category
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

      it "should list all the categories" do
        c1 = FactoryGirl.create(:category, :name => "Foo bar")
        c2 = FactoryGirl.create(:category, :name => "Baz quux")
        get :index
        response.body.should have_selector('td', :text => c1.name)
        response.body.should have_selector('td', :text => c2.name)
      end

      it "should paginate the categories" do
        pending "implement will paginate"
      end

    end


    describe "create category" do

      describe "GET 'new'" do
        it "returns http success" do
          get :new
          response.should be_success
        end
      end

      describe "POST 'create'" do
        it "should changes category count by 1" do
          expect { post :create, :category => {:name => "Test category"} }.to change(Category, :count).by(1)
        end
      end

      describe "with invalid category data" do
        it "should render new category template" do
          post :create, :category => Category.new(name: "")
          response.should render_template("categories/new")
        end
      end

      describe "with valid category data" do
        it "should redirect to categories list" do
          post :create, :category => {:name => "Test category"}
          response.should redirect_to categories_path
        end
      end

    end

    describe "edit category" do

      describe "GET 'edit'" do
        it "returns http success" do
          get :edit, :id => category
          response.should be_success
        end
      end

      describe "PUT 'update'" do

        describe "with invalid category data" do
          it "should return 404 when id is invalid" do
            post :update, :id => "invalid"
            response.response_code.should == 404
          end

          it "should render edit category template" do
            post :update, :id => category, :category => {:name => ""}
            response.should render_template("categories/edit")
          end
        end

        describe "with valid category data" do
          it "redirects to category path" do
            put :update, :id => category, :category => {:name => "Editing category"}
            response.should redirect_to edit_category_path(category)
          end

          it "changes the category name" do
            put :update, :id => category, :category => {:name => "Editing category"}
            category.reload
            category.name.should == "Editing category"
          end

        end

      end

    end

    describe "destroy category" do

      describe "DELETE 'destroy'" do
        it "should return 404 when id is invalid" do
          delete :destroy, :id => "invalid"
          response.response_code.should == 404
        end

        it "should redirect to the category listing path" do
          delete :destroy, :id => category
          response.should redirect_to categories_path
        end

        it "should delete a category" do
          p1 = FactoryGirl.create(:category, :name => "Sample Category")
          expect { delete :destroy, :id => p1 }.to change(Category, :count).by(-1)
        end

      end

    end

    describe "show category" do

      describe "GET 'show'" do
        it "should return 404 when id is invalid" do
          get :show, :id => "invalid"
          response.response_code.should == 404
        end

      end

    end


  end

end
