class PhotosController < ApplicationController
  before_filter :authenticate_user!, :except => [:show]
  layout "admin", :except => [:show]

  def index
    @photos = Photo.all
  end

  def show
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
