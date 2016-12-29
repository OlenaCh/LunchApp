class UsersController < ApplicationController
  before_action :allow_admin_only
  
  def index
  	@users = User.paginate(page: params[:page])
  end
end