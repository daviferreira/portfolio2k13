require 'spec_helper'

describe CategoriesController do

  let(:category) { FactoryGirl.create(:category, :name => "Sample Category") }

    describe "show category" do

      describe "GET 'show'" do
        it "should return 404 when id is invalid" do
          get :show, :id => "invalid"
          response.response_code.should == 404
        end

      end
  end


end
