class PostsController < ApplicationController

  def index
    @posts = Post.published_local.where(:locale => I18n.locale)
    if request['tag']
        @posts = @posts.where("tags LIKE :tag", {:tag => "%#{request['tag']}%"})
    end
    @meta_title = t "posts.meta.title"
    @meta_description = t "posts.meta.description"
  end

  def show
    @post = Post.find_using_slug(params[:id])
    if @post.nil?
      render_404
    else
      @meta_title, @meta_description = @post.get_metas
    end
  end

end
