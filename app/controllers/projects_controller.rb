class ProjectsController < ApplicationController

  def index
    if request['category_id']
      if I18n.locale != I18n.default_locale
        category = Category.find_by_cached_slug(request['category_id'])
      else
        category = Category.find_using_slug(request['category_id'])
      end
      @projects_by_year = Project.published.where(:category_id => category.id).with_translations(I18n.locale).group_by{|v| v.due_date.year}
      @meta_title = category.name
    elsif request['tag']
      # TODO: better tagging
      if I18n.locale != I18n.default_locale
        @projects_by_year = Project.published.with_translations(I18n.locale).where(["project_translations.tags LIKE :tag", {:tag => "%#{request['tag']}%"}]).group_by{|v| v.due_date.year}
      else
        @projects_by_year = Project.published.with_translations(I18n.locale).where(["projects.tags LIKE :tag", {:tag => "%#{request['tag']}%"}]).group_by{|v| v.due_date.year}
      end
      @meta_title = request['tag']
    else
      @projects_by_year = Project.published.with_translations(I18n.locale).group_by{|v| v.due_date.year}
      @meta_title = t "projects.meta.title"
    end
    @meta_description = t "projects.meta.description"
    if @projects_by_year.first
      @year = @projects_by_year.first.first
    else
      @year = Time.now.year
    end
    @categories = Category.all
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
      @categories = Category.all
      @meta_title = @project.name
      @meta_description = "#{@project.description} - #{@project.tags}"
    end
  end

end
