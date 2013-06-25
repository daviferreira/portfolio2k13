class PostsController < ApplicationController

  def index
    if request['tag']
        @posts = Post.published_local.where(:locale => I18n.locale).where("tags LIKE :tag", {:tag => "%#{request['tag']}%"})
    else
        @posts = Post.published_local.where(:locale => I18n.locale)
    end
    @meta_title = t "posts.meta.title"
    @meta_description = t "posts.meta.description"
  end

  def show
    @post = Post.find_using_slug(params[:id])
    if @post.nil?
      render_404
    else
      @meta_title = @post.get_meta_title
      @meta_description = @post.get_meta_description
    end
  end

end
