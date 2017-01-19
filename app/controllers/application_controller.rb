class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  
  def after_sign_in_path_for(resource)
    return users_path if current_user.admin
    items_path
  end
  
  def allow_admin_only
    redirect_to not_admins_path unless current_user.admin
  end
end
