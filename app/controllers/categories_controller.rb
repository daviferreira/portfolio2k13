class CategoriesController < ApplicationController

  def show
    if I18n.locale != I18n.default_locale
      @category = Category.find_by_cached_slug(params[:id]) || render_404
    else
      @category = Category.find_using_slug(params[:id]) || render_404
    end
  end

end
