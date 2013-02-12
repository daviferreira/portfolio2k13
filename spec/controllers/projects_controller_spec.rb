require 'spec_helper'

describe ProjectsController do
  render_views

  let(:user) { FactoryGirl.create(:user) }
  let(:project) { FactoryGirl.create(:project, :name => "Sample Project") }

  describe "access control" do
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
      get :edit, :id => project
      response.should redirect_to new_user_session_path
    end

    it "should deny access to 'update'" do
      post :update, :id => project, :project => project
      response.should redirect_to new_user_session_path
    end

    it "should deny access to 'destroy'" do
      delete :destroy, :id => 1
      response.should redirect_to new_user_session_path
    end
  end

  describe "as a signed-in user" do

    before { sign_in user }

    describe "GET 'index'" do

      it "returns http success" do
        get 'index'
        response.should be_success
      end

      it "should list all the projects" do
        p1 = FactoryGirl.create(:project, :name => "Foo bar")
        p2 = FactoryGirl.create(:project, :name => "Baz quux")
        get 'index'
        response.body.should have_selector('td', :text => p1.name)
        response.body.should have_selector('td', :text => p2.name)
      end

      it "should paginate the projects" do
        pending "implement will paginate"
      end

    end

    describe "create project" do

      describe "GET 'new'" do
        it "returns http success" do
          get 'new'
          response.should be_success
        end
      end

      describe "POST 'create'" do
        it "should changes project count by 1" do
          # TODO: validates category existance
          lambda do
            post 'create', :project => {:name => "Test project",
                                        :description => "Project description",
                                        :url => "http://www.daviferreira.com",
                                        :due_date => Time.now,
                                        :published => true,
                                        :category_id => 1}
          end.should change(Project, :count).by(1)
        end
      end

      describe "with invalid project data" do
        it "should render new project template" do
          post 'create', :project => Project.new(name: "")
          response.should render_template("projects/new")
        end
      end

      describe "with valid project data" do
        it "should redirect to projects list" do
          post 'create', :project => {:name => "Test project",
                                      :description => "Description",
                                      :url => "http://www.daviferreira.com",
                                      :due_date => Time.now,
                                      :category_id => 1}
          response.should redirect_to projects_path
        end
      end

    end

    describe "edit project" do

      describe "GET 'edit'" do
        it "returns http success" do
          get 'edit', :id => project
          response.should be_success
        end
      end

      describe "PUT 'update'" do

        describe "with invalid project data" do
          it "should redirects to the project listing path when id is invalid" do
            post 'update', :id => "invalid"
            response.should redirect_to projects_path
          end

          it "should render edit project template" do
            post 'update', :id => project, :project => {:name => ""}
            response.should render_template("projects/edit")
          end
        end

        describe "with valid project data" do
          it "redirects to project path" do
            put 'update', :id => project, :project => {:name => "Editing project"}
            response.should redirect_to edit_project_path(project)
          end

          it "changes the project name" do
            put 'update', :id => project, :project => {:name => "Editing project"}
            project.reload
            project.name.should == "Editing project"
          end

        end

      end

    end

    describe "destroy project" do

      describe "DELETE 'destroy'" do

        it "should redirect to the project listing path when project is invalid" do
          delete 'destroy', :id => "invalid"
          response.should redirect_to projects_path
        end

        it "should redirect to the project listing path" do
          delete 'destroy', :id => project
          response.should redirect_to projects_path
        end

        it "should delete a project" do
          p1 = FactoryGirl.create(:project, :name => "Sample Project")
          lambda do
            delete :destroy, :id => p1
          end.should change(Project, :count).by(-1)
        end

      end

    end

    describe "show project" do

      describe "GET 'show'" do

        it "should redirect to the root path when project is invalid" do
          get 'show', :id => "invalid"
          response.should redirect_to root_path
        end

      end

    end

  end

end
