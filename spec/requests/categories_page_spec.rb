require 'spec_helper'

describe "category pages" do

  subject { page }
  let(:user) { FactoryGirl.create(:user) }

  describe "as an authenticated user" do

    before do
      visit new_user_session_path
      valid_signin user
    end

    describe "category listing" do
      let!(:c1) { FactoryGirl.create(:category, name: "Foo") }
      let!(:c2) { FactoryGirl.create(:category, name: "Bar") }

      before { visit categories_path }

      it { should have_selector('td', :text => c1.name) }
      it { should have_selector('td', :text => c2.name) }

      it { should have_selector('a.admin-list-edit[href="' + edit_category_path(c1) + '"]') }
      it { should have_selector('a.admin-list-edit[href="' + edit_category_path(c2) + '"]') }
      it { should have_selector('a.admin-list-delete[href="' + category_path(c1) + '"]') }
      it { should have_selector('a.admin-list-delete[href="' + category_path(c1) + '"]') }

      it { should have_selector('a.admin-button[href="' + new_category_path + '"]', :text => I18n.t("categories.add")) }

    end

  end


end