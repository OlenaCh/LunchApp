class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :validatable

  has_many :orders, dependent: :destroy
  
  validates :name, presence: true, length: { in: 2..40 }  
  
  after_create :set_admin
 
  private
  
  def set_admin
    User.first.update_attribute(:admin, true) if  User.count == 1
  end
end