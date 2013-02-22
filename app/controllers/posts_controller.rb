class PostsController < ApplicationController
  before_filter :authenticate_user!, :except => [:show]
  layout "admin", :except => [:show]

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(params[:post])
    if @post.save
      redirect_to posts_path, :flash => { :success => t("posts.created") }
    else
      render "posts/new"
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update_attributes(params[:post])
      redirect_to edit_post_path(@post), :flash => { :success => t("posts.updated") }
    else
      render "edit"
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path, :flash => { :notice => t("posts.deleted") }
  end
end
