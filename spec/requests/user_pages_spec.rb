require 'spec_helper'

describe "User pages" do

  subject { page }

  describe "Devise" do
    before { visit new_user_registration_path }

    describe "error messages" do
      let(:error) { '3 errors prohibited this user from being saved' }
      before { click_button "Sign up" }
      it { should have_content(error) } 
    end
  end

  describe "Name" do

    describe "new user" do
      before { visit new_user_registration_path }

      it { should have_selector('input#user_name[type="text"]') }
    end

    describe "existing user" do
      let(:user) { FactoryGirl.create(:user) }

      before do
        visit new_user_session_path
        valid_signin user 
        visit edit_user_registration_path
      end

      it { should have_selector('input#user_name[type="text"]') }
    end
  end
  
end
