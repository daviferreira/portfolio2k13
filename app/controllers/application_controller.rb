class ApplicationController < ActionController::Base
  before_filter :set_locale
  rescue_from ActiveRecord::RecordNotFound, :with => :render_404
  protect_from_forgery

  def render_404(exception = nil)
    if exception
        logger.info "Rendering 404: #{exception.message}"
    end

    render :file => "#{Rails.root}/public/404", :status => 404, :layout => false, :formats => [:html]
  end

  private
    def set_locale
      I18n.locale = params[:locale] || I18n.default_locale
    end

end
