class PagesController < ApplicationController
  def index
    @projects = Project.published.with_translations(I18n.locale).limit(9)
    @posts = Post.published.where(:locale => I18n.locale).limit(5);
    @open_source_projects = OpenSourceProject.all.sample(2)
    @categories = Category.with_translations(I18n.locale)
    @has_footer = true
    @meta_title = t "meta.title"
    @meta_description = t "meta.description"
  end

  def show
    if I18n.locale != I18n.default_locale
      @page = Page.published.find_by_cached_slug(params[:id]) || render_404
    else
      @page = Page.published.find_using_slug(params[:id]) || render_404
    end
    @meta_title = @page.meta_title || t("meta.title")
    @meta_description = @page.meta_description || t("meta.description")
  end
end
