class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  
  rescue_from ActionController::RoutingError, with: :sth_went_wrong
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ApplicationController::UnauthorizedException, with: :no_access
  
  private
  def no_access
    redirect_to no_access_path
  end
  
  def record_not_found
    redirect_to record_not_found_path
  end
  
  def sth_went_wrong
    redirect_to sth_went_wrong_path
  end
end
