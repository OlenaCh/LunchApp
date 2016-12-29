class Users::RegistrationsController < Devise::RegistrationsController
  prepend_before_filter :require_no_authentication, :only => [ :new, :create, :cancel ]
  prepend_before_filter :authenticate_scope!, :only => [:edit, :update, :destroy]
  
  def update
    super
    current_user.update(name: update_params[:name]) unless update_params[:name].blank?
    current_user.update(organization_id: update_params[:organization_id]) unless update_params[:organization_id].blank?
  end
  
  private
  
  def sign_up_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  
  def update_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, 
                                :current_password, :organization_id)
  end

end