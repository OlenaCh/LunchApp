class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :validatable
  
  after_create :set_admin
 
  private
  
  def set_admin
    User.first.update_attribute(:admin, true) if  User.count == 1
  end
end