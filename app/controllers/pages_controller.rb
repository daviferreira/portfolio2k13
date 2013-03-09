class PagesController < ApplicationController
  def index
    @projects = Project.with_translations(I18n.locale)
    @posts = Post.where(:locale => I18n.locale)
  end
end
