require 'spec_helper'

describe PostsController do

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

  context "when logged in" do

    before { sign_in user }

    describe "GET 'index'" do

      it "returns http success" do
        get :index
        response.should be_success
      end

      it "should list all the posts" do
        p1 = FactoryGirl.create(:post, :title => "Foo bar")
        p2 = FactoryGirl.create(:post, :title => "Baz quux")
        get :index
        assigns(:posts).should eq([p1, p2])
      end

      it "should paginate the posts" do
        pending "implement will paginate"
      end

    end

    describe "create post" do

      describe "GET 'new'" do
        it "returns http success" do
          get :new
          response.should be_success
        end
      end

      describe "POST 'create'" do
        it "should changes post count by 1" do
          expect {
            post :create, :post => {:title => "Test post",
                                    :abstract => "Post description",
                                    :body => "Post body"}
          }.to change(Post, :count).by(1)
        end
      end

      describe "with invalid post data" do
        it "should render new post template" do
          post :create, :post => Post.new(title: "")
          response.should render_template("posts/new")
        end
      end

      describe "with valid post data" do
        it "should redirect to posts list" do
          post :create, :post => {:title => "Test post",
                                  :abstract => "Description",
                                  :body => "Post body"}
          response.should redirect_to posts_path
        end
      end

    end

    describe "edit post" do

      describe "GET 'edit'" do
        it "should return 404 when id is invalid" do
          get :edit, :id => "invalid"
          response.response_code.should == 404
        end

        it "returns http success" do
          get :edit, :id => blog_post
          response.should be_success
        end
      end

      describe "PUT 'update'" do

        describe "with invalid post data" do
          it "should return 404 when id is invalid" do
            post :update, :id => "invalid"
            response.response_code.should == 404
          end

          it "should render edit post template" do
            post :update, :id => blog_post, :post => {:title => ""}
            response.should render_template("posts/edit")
          end
        end

        describe "with valid post data" do
          it "redirects to post path" do
            put :update, :id => blog_post, :post => {:title => "Editing post"}
            blog_post.reload
            response.should redirect_to edit_post_path(blog_post)
          end

          it "changes the post title" do
            put :update, :id => blog_post, :post => {:title => "Editing post"}
            blog_post.reload
            blog_post.title.should == "Editing post"
          end

        end

      end

    end

    describe "destroy post" do

      describe "DELETE 'destroy'" do

        it "should return 404 when id is invalid" do
          delete :destroy, :id => "invalid"
          response.response_code.should == 404
        end

        it "should redirect to the post listing path" do
          delete :destroy, :id => blog_post
          response.should redirect_to posts_path
        end

        it "should delete a post" do
          p1 = FactoryGirl.create(:post, :title => "Sample Post")
          expect { delete :destroy, :id => p1 }.to change(Post, :count).by(-1)
        end

      end

    end

    describe "show post" do

      describe "GET 'show'" do

        it "should return 404 when post is invalid" do
          get :show, :id => "invalid"
          response.response_code.should == 404
        end

      end

    end



  end

end
