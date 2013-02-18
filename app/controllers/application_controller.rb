class ApplicationController < ActionController::Base
  rescue_from ActiveRecord::RecordNotFound, :with => :render_404
  protect_from_forgery

  private
    def render_404(exception = nil)
      if exception
          logger.info "Rendering 404: #{exception.message}"
      end

      render :file => "#{Rails.root}/public/404", :status => 404, :layout => false, :formats => [:html]
    end
end
