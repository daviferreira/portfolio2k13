require 'spec_helper'

describe PostsController do

  let!(:blog_post) { FactoryGirl.create(:post) }

  describe "projects listing" do

    describe "GET 'index'" do

      it "should return http success" do
        get :index
        response.should be_success
      end

      it "should list only published posts" do
        get :index
        unpublished_post = FactoryGirl.create(:post, :published => false)
        assigns(:posts).should == [blog_post]
      end

      it "should have the right meta title and description" do
        get :index
        assigns(:meta_title).should == I18n.translate("posts.meta.title")
        assigns(:meta_description).should == I18n.translate("posts.meta.description")
      end

      it "should list posts by tags" do
        tagged_post = FactoryGirl.create(:post, :tags => "javascript")
        get :index, :tag => "javascript"
        assigns(:posts).should == [tagged_post]
        assigns(:meta_title).should == "javascript"
      end

    end

  end

  describe "show post" do

    describe "GET 'show'" do

      it "should return 404 when post is invalid" do
        get :show, :id => "invalid"
        response.response_code.should == 404
      end

      it "should return http success" do
        get :show, :id => blog_post
        response.should be_success
      end

    end

  end

end
