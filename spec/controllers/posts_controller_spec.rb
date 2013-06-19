require 'spec_helper'

describe PostsController do

  let(:blog_post) { FactoryGirl.create(:post) }


  describe "show post" do

    describe "GET 'show'" do

      it "should return 404 when post is invalid" do
        get :show, :id => "invalid"
        response.response_code.should == 404
      end

    end

  end

end
