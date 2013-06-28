class Admin::ProjectsController < Admin::AdminController
  def index
    @projects = Project.all
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(params[:project])
    if @project.save
      redirect_to admin_projects_path,
                  :flash => { :success => t("projects.created") }
    else
      render "new"
    end
  end

  def edit
    @project = Project.find_using_slug(params[:id]) || render_404
  end

  def update
    @project = Project.find_using_slug(params[:id])
    if @project.nil?
      render_404
    elsif @project.update_attributes(params[:project])
      redirect_to edit_admin_project_path(@project),
                  :flash => { :success => t("projects.updated") }
    else
      render "edit"
    end
  end

  def destroy
    @project = Project.find_using_slug(params[:id])
    if @project.nil?
      render_404
    else
      @project.destroy
      redirect_to admin_projects_path,
                  :flash => { :notice => t("projects.deleted") }
    end
  end

end
