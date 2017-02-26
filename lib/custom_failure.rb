class CustomFailure < Devise::FailureApp
  def respond
    http_auth and return false if http_auth?
    redirect_to unauthorized_path
  end
end