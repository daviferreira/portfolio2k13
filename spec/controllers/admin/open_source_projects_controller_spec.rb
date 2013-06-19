require 'spec_helper'

describe Admin::OpenSourceProjectsController do
  let(:user) { FactoryGirl.create(:user) }
  let(:open_source_project) { FactoryGirl.create(:open_source_project, :title => "Sample OpenSourceProject") }

  context "when logged out" do
    it "should deny access to 'index'" do
      get :index
      response.should redirect_to new_user_session_path
    end

    it "should deny access to 'new'" do
      get :new
      response.should redirect_to new_user_session_path
    end

    it "should deny access to 'create'" do
      post :create
      response.should redirect_to new_user_session_path
    end

    it "should deny access to 'edit'" do
      get :edit, :id => open_source_project
      response.should redirect_to new_user_session_path
    end

    it "should deny access to 'update'" do
      post :update, :id => open_source_project, :open_source_project => open_source_project
      response.should redirect_to new_user_session_path
    end

    it "should deny access to 'destroy'" do
      delete :destroy, :id => 1
      response.should redirect_to new_user_session_path
    end

  end

  context "when logged in" do

    before { sign_in user }

    describe "GET 'index'" do

      it "returns http success" do
        get :index
        response.should be_success
      end

      it "should paginate the open_source_projects" do
        pending "implement will paginate"
      end

    end

    describe "create open_source_project" do

      describe "GET 'new'" do
        it "returns http success" do
          get :new
          response.should be_success
        end
      end

      describe "POST 'create'" do
        it "should changes open_source_project count by 1" do
          expect {
            post :create, :open_source_project => {:title => "Test open_source_project",
                                        :description => "OpenSourceProject description",
                                        :url => "http://www.daviferreira.com"}
          }.to change(OpenSourceProject, :count).by(1)
        end
      end

      describe "with invalid open_source_project data" do
        it "should render new open_source_project template" do
          post :create, :open_source_project => OpenSourceProject.new(title: "")
          response.should render_template("admin/open_source_projects/new")
        end
      end

      describe "with valid open_source_project data" do
        it "should redirect to open_source_projects list" do
          post :create, :open_source_project => {:title => "Test open_source_project",
                                      :description => "Description",
                                      :url => "http://www.daviferreira.com"}
          response.should redirect_to admin_open_source_projects_path
        end
      end

    end

    describe "edit open_source_project" do

      describe "GET 'edit'" do
        it "should return 404 when id is invalid" do
          get :edit, :id => "invalid"
          response.response_code.should == 404
        end

        it "returns http success" do
          get :edit, :id => open_source_project
          response.should be_success
        end
      end

      describe "PUT 'update'" do

        describe "with invalid open_source_project data" do
          it "should return 404 when id is invalid" do
            post :update, :id => "invalid"
            response.response_code.should == 404
          end

          it "should render edit open_source_project template" do
            post :update, :id => open_source_project, :open_source_project => {:title => ""}
            response.should render_template("admin/open_source_projects/edit")
          end
        end

        describe "with valid open_source_project data" do
          it "redirects to open_source_project path" do
            put :update, :id => open_source_project, :open_source_project => {:title => "Editing open_source_project"}
            open_source_project.reload
            response.should redirect_to edit_admin_open_source_project_path(open_source_project)
          end

          it "changes the open_source_project title" do
            put :update, :id => open_source_project, :open_source_project => {:title => "Editing open_source_project"}
            open_source_project.reload
            open_source_project.title.should == "Editing open_source_project"
          end

        end

      end

    end

    describe "destroy open_source_project" do

      describe "DELETE 'destroy'" do

        it "should return 404 when id is invalid" do
          delete :destroy, :id => "invalid"
          response.response_code.should == 404
        end

        it "should redirect to the open_source_project listing path" do
          delete :destroy, :id => open_source_project
          response.should redirect_to admin_open_source_projects_path
        end

        it "should delete a open_source_project" do
          p1 = FactoryGirl.create(:open_source_project, :title => "Sample OpenSourceProject")
          expect { delete :destroy, :id => p1 }.to change(OpenSourceProject, :count).by(-1)
        end

      end

    end

  end

end
