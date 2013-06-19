class PagesController < ApplicationController
  def index
    @projects = Project.published.with_translations(I18n.locale).limit(9)
    @posts = Post.published.where(:locale => I18n.locale).limit(5);
    @open_source_projects = OpenSourceProject.all.sample(2)
    @categories = Category.with_translations(I18n.locale)
    @has_footer = true
  end
end
