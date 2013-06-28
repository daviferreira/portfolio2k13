class ProjectsController < ApplicationController

  def index
    get_projects
    @meta_description = t "projects.meta.description"
    @year = get_year
    @categories = Category.all
  end

  def show
    @project = Project.new.get_localized(params[:id])
    render_404 and return if @project.nil?
    @categories = Category.all
    @meta_title, @meta_description = @project.get_metas
  end

  private

    def get_projects
      if request['category_id']
        with_category and return
      elsif request['tag']
        with_tag and return
      end
      by_year
    end

    def by_year
      @projects_by_year = Project.published.with_translations(I18n.locale)
                                           .group_by{|v| v.due_date.year}
      @meta_title = t "projects.meta.title"
    end

    def with_category
      category = Category.new.get_localized(request['category_id'])
      @projects_by_year = Project.published
                                 .where(:category_id => category.id)
                                 .with_translations(I18n.locale)
                                 .group_by{|v| v.due_date.year}
      @meta_title = category.name
    end

    def with_tag
      @projects_by_year = Project.new.get_by_tag(request['tag'])
      @meta_title = request['tag']
    end

    def get_year
      if not @projects_by_year.keys.empty?
        @projects_by_year.keys.first
      else
        Time.now.year
      end
    end

end
