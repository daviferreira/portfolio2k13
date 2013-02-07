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

    it { should have_selector('li.user-name', :text => 'Davi Ferreira') }
    it { should have_selector('a.logout', :text => "#{I18n.t('logout')}") }
    it { should have_selector('ul > li > a', :text => "#{I18n.t('projects.add')}") }
  end

end
