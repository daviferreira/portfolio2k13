class OpenSourceProjectsController < ApplicationController
  def index
    @open_source_projects = OpenSourceProject.with_translations(I18n.locale)
    @meta_title = t "open_source_projects.meta.title"
    @meta_description = t "open_source_projects.meta.description"
  end
end
