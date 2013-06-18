class ProjectsController < ApplicationController

  def index
    @projects = Project.all
  end

  def show
    if I18n.locale != I18n.default_locale
      @project = Project.find_by_cached_slug(params[:id]) || render_404
    else
      @project = Project.find_using_slug(params[:id]) || render_404
    end
  end

end
