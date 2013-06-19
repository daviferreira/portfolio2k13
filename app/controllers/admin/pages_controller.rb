class Admin::PagesController < Admin::AdminController

  def index
    @pages = Page.all
  end

  def new
    @page = Page.new()
  end

  def create
    @page = Page.new(params[:page])
    if @page.save
      redirect_to admin_pages_path, :flash => { :success => t("pages.created") }
    else
      render "new"
    end
  end

  def edit
    @page = Page.find_using_slug(params[:id]) || render_404
  end

  def update
    @page = Page.find_using_slug(params[:id])
    if @page.nil?
      render_404
    elsif @page.update_attributes(params[:page])
      redirect_to edit_admin_page_path(@page), :flash => { :success => t("pages.updated") }
    else
      render "edit"
    end
  end

  def destroy
    @page = Page.find_using_slug(params[:id])
    if @page.nil?
      render_404
    else
      @page.destroy
      redirect_to admin_pages_path, :flash => { :notice => t("pages.deleted") }
    end
  end
end
