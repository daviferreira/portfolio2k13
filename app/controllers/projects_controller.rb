class ProjectsController < ApplicationController
  before_filter :authenticate_user!, :except => [:show]
  layout "admin"

  def index
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
