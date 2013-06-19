require 'spec_helper'

describe Admin::PagesController do

  let(:user) { FactoryGirl.create(:user) }
  let(:blog_page) { FactoryGirl.create(:page) }

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
      get :edit, :id => blog_page
      response.should redirect_to new_user_session_path
    end

    it "should deny access to 'update'" do
      post :update, :id => blog_page, :page => blog_page
      response.should redirect_to new_user_session_path
    end

    it "should deny access to 'destroy'" do
      delete :destroy, :id => blog_page
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

      it "should list all the pages" do
        p1 = FactoryGirl.create(:page, :title => "Foo bar")
        p2 = FactoryGirl.create(:page, :title => "Baz quux")
        get :index
        assigns(:pages).should eq([p1, p2])
      end

      it "should paginate the pages" do
        pending "implement will paginate"
      end

    end

    describe "create page" do

      describe "GET 'new'" do
        it "returns http success" do
          get :new
          response.should be_success
        end
      end

      describe "POST 'create'" do
        it "should changes page count by 1" do
          expect {
            post :create, :page => {:title => "Test page",
                                    :body => "Page body"}
          }.to change(Page, :count).by(1)
        end
      end

      describe "with invalid page data" do
        it "should render new page template" do
          post :create, :page => Page.new(title: "")
          response.should render_template("admin/pages/new")
        end
      end

      describe "with valid page data" do
        it "should redirect to pages list" do
          post :create, :page => {:title => "Test page",
                                  :body => "Page body"}
          response.should redirect_to admin_pages_path
        end
      end

    end

    describe "edit page" do

      describe "GET 'edit'" do
        it "should return 404 when id is invalid" do
          get :edit, :id => "invalid"
          response.response_code.should == 404
        end

        it "returns http success" do
          get :edit, :id => blog_page
          response.should be_success
        end
      end

      describe "PUT 'update'" do

        describe "with invalid page data" do
          it "should return 404 when id is invalid" do
            post :update, :id => "invalid"
            response.response_code.should == 404
          end

          it "should render edit page template" do
            post :update, :id => blog_page, :page => {:title => ""}
            response.should render_template("admin/pages/edit")
          end
        end

        describe "with valid page data" do
          it "redirects to page path" do
            put :update, :id => blog_page, :page => {:title => "Editing page"}
            blog_page.reload
            response.should redirect_to edit_admin_page_path(blog_page)
          end

          it "changes the page title" do
            put :update, :id => blog_page, :page => {:title => "Editing page"}
            blog_page.reload
            blog_page.title.should == "Editing page"
          end

        end

      end

    end

    describe "destroy page" do

      describe "DELETE 'destroy'" do

        it "should return 404 when id is invalid" do
          delete :destroy, :id => "invalid"
          response.response_code.should == 404
        end

        it "should redirect to the page listing path" do
          delete :destroy, :id => blog_page
          response.should redirect_to admin_pages_path
        end

        it "should delete a page" do
          p1 = FactoryGirl.create(:page, :title => "Sample Page")
          expect { delete :destroy, :id => p1 }.to change(Page, :count).by(-1)
        end

      end

    end

  end

end
