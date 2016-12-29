class OrganizationsController < ApplicationController
  before_action :allow_user_only
  
  def new
    @organization = Organization.new
  end
  
  def create
    @organization = Organization.create(organization_params)
    redirect_to edit_user_registration_path
  end
  
  private
  
  def organization_params
    params.require(:organization).permit(:title, :address, :phone, :email)
  end
end
