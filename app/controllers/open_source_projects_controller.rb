class OpenSourceProjectsController < ApplicationController
  def index
    @open_source_projects = OpenSourceProject.all
  end
end
