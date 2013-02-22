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

    it { should have_selector('a.logout', :text => "#{I18n.t('logout')}") }

    it { should have_selector('ul > li > a[href="' + root_path + '"]', :text => "#{I18n.t('home')}") }
    it { should have_selector('ul > li > a[href="' + projects_path + '"]', :text => "#{I18n.t('projects.list')}") }
    it { should have_selector('ul > li > a[href="' + categories_path + '"]', :text => "#{I18n.t('categories.list')}") }
    it { should have_selector('ul > li > a[href="' + photos_path + '"]', :text => "#{I18n.t('photos.list')}") }
    it { should have_selector('ul > li > a[href="' + posts_path + '"]', :text => "#{I18n.t('posts.list')}") }

  end

end
