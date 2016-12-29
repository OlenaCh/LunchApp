class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  
  def after_sign_in_path_for(resource)
    if current_user.admin
      return users_path
    else
      return items_path
    end
  end
  
  def allow_admin_only
    redirect_to not_admins_path unless current_user.admin
  end
  
  def allow_user_only
    redirect_to not_users_path if current_user.admin
  end
end
