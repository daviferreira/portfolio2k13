class PostsController < ApplicationController

  def index
    @posts = Post.published_local.where(:locale => I18n.locale)
    @meta_title = t "posts.meta.title"
    @meta_description = t "posts.meta.description"
  end

  def show
    @post = Post.find_using_slug(params[:id])
    if @post.nil?
      render_404
    else
      @post.body = BlueCloth::new(@post.body).to_html
    end
    @meta_title = @post.meta_title || @post.title
    @meta_description = @post.meta_description || @post.abstract.split(" ").each_with_object("") {|x,ob| break ob unless (ob.length + " ".length + x.length <= 160);ob << (" " + x)}.strip
  end

end
