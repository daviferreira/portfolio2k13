class ProjectsController < ApplicationController

  def index
    @projects_by_year = Project.published.with_translations(I18n.locale).group_by{|v| v.due_date.year}
    if @projects_by_year.first
      @year = @projects_by_year.first.first
    else
      @year = Time.now.year
    end
    @meta_title = t "projects.meta.title"
    @meta_description = t "projects.meta.description"
  end

  def show
    if I18n.locale != I18n.default_locale
      @project = Project.find_by_cached_slug(params[:id])
    else
      @project = Project.find_using_slug(params[:id])
    end
    if @project.nil?
      render_404
    else
      @meta_title = @project.name
      @meta_description = "#{@project.description} - #{@project.tags}"
    end
  end

end
