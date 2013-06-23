class OpenSourceProjectsController < ApplicationController
  def index
    @open_source_projects = OpenSourceProject.with_translations(I18n.locale)
  end
end
