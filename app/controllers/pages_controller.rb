class PagesController < ApplicationController
  def index
    @projects = Project.published.with_translations(locale).limit(9)
    @posts = Post.published.where(:locale => locale).limit(5)
    @open_source_projects = OpenSourceProject.all.sample(2)
    @categories = Category.with_translations(locale)
    index_config
  end

  def show
    @page = Page.new.get_localized(params[:id])
    render_404 and return if @page.nil?
    @page_sidebar = @page.get_sidebar
    @meta_title, @meta_description = @page.get_metas
  end

  private

    def locale
      I18n.locale
    end

    def index_config
      @has_footer = true
      @meta_title = t "meta.title"
      @meta_description = t "meta.description"
    end

end
