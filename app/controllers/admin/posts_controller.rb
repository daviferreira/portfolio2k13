class Admin::PostsController < Admin::AdminController

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new(:locale => I18n.default_locale)
  end

  def create
    @post = Post.new(params[:post])
    if @post.save
      redirect_to admin_posts_path, :flash => { :success => t("posts.created") }
    else
      render "new"
    end
  end

  def edit
    @post = Post.find_using_slug(params[:id]) || render_404
  end

  def update
    @post = Post.find_using_slug(params[:id])
    if @post.nil?
      render_404
    elsif @post.update_attributes(params[:post])
      redirect_to edit_admin_post_path(@post), :flash => { :success => t("posts.updated") }
    else
      render "edit"
    end
  end

  def destroy
    @post = Post.find_using_slug(params[:id])
    if @post.nil?
      render_404
    else
      @post.destroy
      redirect_to admin_posts_path, :flash => { :notice => t("posts.deleted") }
    end
  end
end
