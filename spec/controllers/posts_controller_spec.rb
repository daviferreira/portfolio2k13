require 'spec_helper'

describe PostsController do

  let(:blog_post) { FactoryGirl.create(:post) }

  describe "projects listing" do
    describe "GET 'index'" do
      it "returns http success" do
        get :index
        response.should be_success
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
