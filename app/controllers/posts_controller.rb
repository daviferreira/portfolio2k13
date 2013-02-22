class PostsController < ApplicationController
  before_filter :authenticate_user!, :except => [:show]
  layout "admin", :except => [:show]

  def new
    @post = Post.new
  end

  def create
  end

  def update
  end

  def edit
  end

  def destroy
  end

  def index
    @posts = Post.all
  end

  def show
  end
end
