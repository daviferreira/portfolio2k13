class PostsController < ApplicationController

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find_using_slug(params[:id])
    if @post.nil?
      render_404
    else
      @post.body = BlueCloth::new(@post.body).to_html
    end
  end

end
