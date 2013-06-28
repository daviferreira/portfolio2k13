class ProjectsController < ApplicationController

  def index
    if request['category_id']
      with_category
    elsif request['tag']
      with_tag
    else
      @projects_by_year = Project.published.with_translations(I18n.locale).group_by{|v| v.due_date.year}
      @meta_title = t "projects.meta.title"
    end
    @meta_description = t "projects.meta.description"
    if not @projects_by_year.keys.empty?
      @year = @projects_by_year.keys.first
    else
      @year = Time.now.year
    end
    @categories = Category.all
  end

  def show
    @project = Project.new.get_localized(params[:id])
    render_404 and return if @project.nil?
    @categories = Category.all
    @meta_title, @meta_description = @project.get_metas
  end

  private

    def with_category
      category = Category.new.get_localized(request['category_id'])
      @projects_by_year = Project.published.where(:category_id => category.id).with_translations(I18n.locale).group_by{|v| v.due_date.year}
      @meta_title = category.name
    end

    def with_tag
      @projects_by_year = Project.new.get_by_tag(request['tag'])
      @meta_title = request['tag']
    end

end
