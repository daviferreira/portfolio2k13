require 'spec_helper'

describe ProjectsController do

  let!(:project) { FactoryGirl.create(:project, :published => true) }

  describe "projects listing" do

    describe "GET 'index'" do

      it "should return http success" do
        get :index
        response.should be_success
      end

      it "should list only published projects" do
        get :index
        unpublished_project = FactoryGirl.create(:project)
        assigns(:projects_by_year).should == {Time.now.year => [project]}
      end

      it "should have the right metas" do
        get :index
        assigns(:meta_title).should == I18n.t('projects.meta.title')
        assigns(:meta_description).should == I18n.t('projects.meta.description')
      end

      # TODO: test multiple projects, years
      it "should return the most recent project's year" do
        get :index
        assigns(:year).should == Time.now.year
      end

      it "should return the current year when there are no projects" do
        Project.all.each { |project| project.destroy }
        get :index
        assigns(:year).should == Time.now.year
      end

      it "should list post by categories" do
        another_project = FactoryGirl.create(:project, :published => true,
                                                       :category => FactoryGirl.create(:category))
        get :index, :category_id => project.category.id
        assigns(:projects_by_year).should == {Time.now.year => [project]}
      end

      it "should list post by tags" do
        tagged_project = FactoryGirl.create(:project, :published => true,
                                                      :tags => "php,css,javascript,html")
        get :index, :tag => "javascript"
        assigns(:projects_by_year).should == {Time.now.year => [tagged_project]}
      end

    end

  end

  describe "show project" do

    describe "GET 'show'" do

      it "should return 404 when project is invalid" do
        get :show, :id => "invalid"
        response.response_code.should == 404
      end

      it "should return http success" do
        get :show, :id => project
        response.should be_success
      end

      it "should find localized project" do
        pending
      end

    end

  end

end
