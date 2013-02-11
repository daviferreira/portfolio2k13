class ProjectsController < ApplicationController
  before_filter :authenticate_user!, :except => [:show]
  before_filter :get_project_or_redirect, :only => [:show, :edit, :update, :destroy]
  layout "admin", :except => [:show]

  def index
    @projects = Project.find(:all)
  end

  def show
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new params[:project]
    if @project.save
      flash[:success] = "Project successfully created, yay!"
      redirect_to projects_path
    else
      render 'projects/new'
    end
  end

  def edit
  end

  def update
    if @project.update_attributes(params[:project])
      redirect_to edit_project_path(@project), :flash => { :success => t("projects.updated") }
    else
      render 'edit'
    end
  end

  def destroy
    @project.destroy
    redirect_to projects_path, :flash => { :notice => t("projects.deleted") }
  end

  private

    def get_project_or_redirect
      @project = Project.find_by_id(params[:id])
      redirect_to projects_path, :flash => { :error => t("projects.invalid") } if not @project
    end

end
