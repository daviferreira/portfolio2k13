class PagesController < ApplicationController
  def index
    @projects = Project.published.with_translations(I18n.locale).limit(9)
    @posts = Post.where(:locale => I18n.locale)
    @categories = Category.with_translations(I18n.locale)
  end

  def projects
    @projects = Project.published.with_translations(I18n.locale)
  end

  def blog
    @posts = Post.published.where(:locale => I18n.locale)
  end
end
