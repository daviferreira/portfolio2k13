class CategoriesController < ApplicationController
  before_filter :authenticate_user!, :except => [:show]
  layout "admin", :except => [:show]

  def index
    @categories = Category.find(:all)
  end

  def show
    @category = Category.find(params[:id])
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(params[:category])
    if @category.save
      redirect_to categories_path, :flash => { :success => t("categories.created") }
    else
      render "categories/new"
    end
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    if @category.update_attributes(params[:category])
      redirect_to edit_category_path(@category), :flash => { :success => t("categories.updated") }
    else
      render "edit"
    end
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    redirect_to categories_path, :flash => { :notice => t("categories.deleted") }
  end

end
