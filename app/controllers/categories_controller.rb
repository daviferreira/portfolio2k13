class CategoriesController < ApplicationController
  before_filter :authenticate_user!, :except => [:show]
  layout "admin", :except => [:show]

  def index
    @categories = Category.find(:all)
  end

end