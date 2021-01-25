class ApplicationController < ActionController::Base
  rescue_from ActiveRecord::RecordNotFound, with: :not_found_page
  # skip_before_action :verify_authenticity_token
  
  def not_found_page
    render plain: "404 Not Found",
           status: :not_found
  end
end
