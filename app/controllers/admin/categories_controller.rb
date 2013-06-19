class Admin::CategoriesController < Admin::AdminController

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(params[:category])
    if @category.save
      redirect_to admin_categories_path, :flash => { :success => t("categories.created") }
    else
      render "categories/new"
    end
  end

  def edit
    @category = Category.find_using_slug(params[:id]) || render_404
  end

  def update
    @category = Category.find_using_slug(params[:id])
    if @category.nil?
      render_404
    elsif @category.update_attributes(params[:category])
      redirect_to edit_admin_category_path(@category), :flash => { :success => t("categories.updated") }
    else
      render "edit"
    end
  end

  def destroy
    @category = Category.find_using_slug(params[:id])
    if @category.nil?
      render_404
    else
      @category.destroy
      redirect_to admin_categories_path, :flash => { :notice => t("categories.deleted") }
    end
  end

end
