require 'spec_helper'

describe 'Admin Page' do

  subject { page }

  context "Authenticated user" do
    let(:user) { FactoryGirl.create(:user, :name => "Davi Ferreira") }

    before do
      visit new_user_session_path
      valid_signin user
      visit admin_root_path
    end

    it { should have_selector('a.logout', :text => "#{I18n.t('logout')}") }

    it { should have_selector('ul > li > a[href="' + admin_projects_path + '"]', :text => "#{I18n.t('projects.list')}") }
    it { should have_selector('ul > li > a[href="' + admin_categories_path + '"]', :text => "#{I18n.t('categories.list')}") }
    it { should have_selector('ul > li > a[href="' + admin_photos_path + '"]', :text => "#{I18n.t('photos.list')}") }
    it { should have_selector('ul > li > a[href="' + admin_posts_path + '"]', :text => "#{I18n.t('posts.list')}") }

    describe "logout" do
      before do
        click_link I18n.t('logout')
      end

      it { should have_selector('input#user_email') }
      it { should have_selector('input#user_password') }
      it { should have_selector('input[type="submit"]') }
    end

  end

end
