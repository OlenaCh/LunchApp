class Admins::SessionsController < Devise::SessionsController
  def create
    resource = Admin.find_for_database_authentication(email: params[:admin][:email])
    unless resource && resource.valid_password?(params[:admin][:password])
      redirect_to unauthorized_path and return false
    end
    login resource
  end
  
  private
  
  def login resource
    sign_in :admin, resource
    return render json: { status: 200 }
  end
end