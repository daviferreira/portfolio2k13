class Admin::OpenSourceProjectsController < Admin::AdminController
  def index
    @open_source_projects = OpenSourceProject.all
  end

  def new
    @open_source_project = OpenSourceProject.new
  end

  def create
    @open_source_project = OpenSourceProject.new(params[:open_source_project])
    if @open_source_project.save
      redirect_to admin_open_source_projects_path, :flash => { :success => t("open_source_projects.created") }
    else
      render "new"
    end
  end

  def edit
    @open_source_project = OpenSourceProject.find(params[:id]) || render_404
  end

  def update
    @open_source_project = OpenSourceProject.find(params[:id])
    if @open_source_project.update_attributes(params[:open_source_project])
      redirect_to edit_admin_open_source_project_path(@open_source_project), :flash => { :success => t("open_source_projects.updated") }
    else
      render "edit"
    end
  end

  def destroy
    @open_source_project = OpenSourceProject.find(params[:id])
    @open_source_project.destroy
    redirect_to admin_open_source_projects_path, :flash => { :notice => t("open_source_projects.deleted") }
  end

end
