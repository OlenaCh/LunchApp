class Admins::SessionsController < Devise::SessionsController
  protected
  def after_sign_in_path_for(resource)
    menus_path
  end
end