class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  
  rescue_from ActionController::RoutingError, with: :no_route
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  
  private
  
  def no_route
    redirect_to no_route_path
  end
  
  def record_not_found
    redirect_to record_not_found_path
  end
end
