class PagesController < ApplicationController
  def index
    @projects = Project.published.with_translations(I18n.locale).limit(9)
    @posts = Post.where(:locale => I18n.locale)
    @categories = Category.with_translations(I18n.locale)
  end

  def projects
    @projects_by_year = Project.published.with_translations(I18n.locale).group_by{|v| v.due_date.year}
    @year = @projects_by_year.first.first
  end

  def blog
    @posts = Post.published_local.where(:locale => I18n.locale)
  end
end
