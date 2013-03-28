class PagesController < ApplicationController
  def index
    @projects = Project.with_translations(I18n.locale).limit(9)
    @posts = Post.where(:locale => I18n.locale)
    @categories = Category.with_translations(I18n.locale)
  end
end
