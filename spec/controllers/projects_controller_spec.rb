require 'spec_helper'

describe ProjectsController do

  after { I18n.locale = I18n.default_locale }

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

      it "should list posts by categories" do
        another_project = FactoryGirl.create(:project, :published => true,
                                                       :category => FactoryGirl.create(:category))
        get :index, :category_id => project.category.id
        assigns(:projects_by_year).should == {Time.now.year => [project]}
      end

      it "should list posts by localized category" do
        category = FactoryGirl.create(:category)
        localized_project = FactoryGirl.create(:project, :published => true,
                                                         :category => category)
        I18n.locale = :en
        category.name = "English category"
        category.generate_slug!
        category.save
        localized_project.name = "English Project"
        localized_project.description = "English Project"
        localized_project.generate_slug!
        localized_project.save
        get :index, { :locale => :en, :category_id => category }
        assigns(:projects_by_year).should == {Time.now.year => [localized_project]}
      end

      it "should list posts by tags" do
        tagged_project = FactoryGirl.create(:project, :published => true,
                                                      :tags => "php,css,javascript,html")
        get :index, :tag => "javascript"
        assigns(:projects_by_year).should == {Time.now.year => [tagged_project]}
      end

      it "shoud list localized posts by tags" do
        tagged_project = FactoryGirl.create(:project, :published => true)
        I18n.locale = :en
        tagged_project.name = "English Project"
        tagged_project.description = "English Project"
        tagged_project.tags = "english,css,php"
        tagged_project.generate_slug!
        tagged_project.save
        get :index, {:locale => :en, :tag => "english"}
        get :index, :tag => "javascript"
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
        I18n.locale = :en
        project.name = "Test project"
        project.description = "Project description"
        project.generate_slug!
        project.save
        get :show, { :id => project, :locale => I18n.locale }
        response.should be_success
      end

    end

  end

end
