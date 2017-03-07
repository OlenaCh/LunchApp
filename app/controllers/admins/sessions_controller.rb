class Admins::SessionsController < Devise::SessionsController
  def create
    resource = Admin.find_for_database_authentication(email: params[:admin][:email])
    unless resource && resource.valid_password?(params[:admin][:password])
      send_msg(400) and return
    end
    login resource
  end
  
  private
  
  def login resource
    sign_in :admin, resource
    send_msg(200)
  end
  
  def send_msg status
    render json: { status: status }
  end
end