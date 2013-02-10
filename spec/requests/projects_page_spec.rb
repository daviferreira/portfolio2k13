require 'spec_helper'

describe "project pages" do

  subject { page }
  let(:user) { FactoryGirl.create(:user) }

  describe "as an authenticated user" do

    before do
      visit new_user_session_path
      valid_signin user
    end

    describe "project listing" do
      let!(:p1) { FactoryGirl.create(:project, name: "Foo") }
      let!(:p2) { FactoryGirl.create(:project, name: "Bar") }

      before { visit projects_path }

      it { should have_selector('td', :text => p1.name) }
      it { should have_selector('td', :text => p2.name) }

      it { should have_selector('a.admin-list-edit[href="' + edit_project_path(p1) + '"]') }
      it { should have_selector('a.admin-list-edit[href="' + edit_project_path(p2) + '"]') }
      it { should have_selector('a.admin-list-delete[href="' + project_path(p1) + '"]') }
      it { should have_selector('a.admin-list-delete[href="' + project_path(p1) + '"]') }

    end

  end


end