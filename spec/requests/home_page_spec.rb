require 'spec_helper'

describe 'Home Page' do

  subject { page }

  describe "As an authenticated user" do
    let(:user) { FactoryGirl.create(:user, :name => "Davi Ferreira") }

    before do
      visit new_user_session_path
      valid_signin user 
      visit root_path 
    end

    it { should have_selector('div.user-info', :text => 'Davi Ferreira') }
    it { should have_selector('a.logout') }
  end

end
