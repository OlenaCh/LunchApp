class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  rescue_from ActionController::RoutingError, with: :no_route
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  
  before_action :save_request_referer, only: [:create, :update]
  
  private
  
  def no_route
    redirect_to no_route_path
  end
  
  def record_not_found
    redirect_to record_not_found_path
  end
  
  def save_request_referer
    session[:return_to] ||= request.referer
  end
end
