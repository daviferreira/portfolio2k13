class CategoriesController < ApplicationController
  before_filter :authenticate_user!, :except => [:show]
  before_filter :get_category_or_redirect, :only => [:edit, :update, :destroy]
  layout "admin", :except => [:show]

  def index
    @categories = Category.find(:all)
  end

  # TODO: use 404 instead of redirect
  def show
    @category = Category.find_by_id(params[:id])
    redirect_to root_path if not @category
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new params[:category]
    if @category.save
      flash[:success] = "Category successfully created, yay!"
      redirect_to categories_path
    else
      render 'categories/new'
    end
  end

  def edit
  end

  def update
    if @category.update_attributes(params[:category])
      redirect_to edit_category_path(@category), :flash => { :success => t("categories.updated") }
    else
      render 'edit'
    end
  end

  def destroy
    @category.destroy
    redirect_to categories_path, :flash => { :notice => t("categories.deleted") }
  end

  private

    def get_category_or_redirect
      @category = Category.find_by_id(params[:id])
      redirect_to categories_path, :flash => { :error => t("categories.invalid") } if not @category
    end

end