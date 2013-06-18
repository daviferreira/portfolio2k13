class Admin::PhotosController < Admin::AdminControler

  def index
    @photos = Photo.joins(:project).order('projects.name ASC, photos.`order` ASC')
  end

  def new
    @photo = Photo.new
  end

  def create
    @photo = Photo.new(params[:photo])
    if @photo.save
      redirect_to photos_path, :flash => { :success => t("photos.created") }
    else
      render "photos/new"
    end
  end

  def edit
    @photo = Photo.find(params[:id])
  end

  def update
    @photo = Photo.find(params[:id])
    if @photo.update_attributes(params[:photo])
      redirect_to edit_photo_path(@photo), :flash => { :success => t("photos.updated") }
    else
      render "edit"
    end
  end

  def destroy
    @photo = Photo.find(params[:id])
    @photo.destroy
    redirect_to photos_path, :flash => { :notice => t("photos.deleted") }
  end
end
