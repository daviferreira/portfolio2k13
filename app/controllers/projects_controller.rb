class ProjectsController < ApplicationController
  before_filter :authenticate_user!, :except => [:show]
  layout "admin"

  def index
    @projects = Project.find(:all, :order => "name")
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
  end

  def destroy
  end
end
