class Organization < ActiveRecord::Base
  has_many :users
  
  validates :title, presence: true, length: { in: 4..30 }, uniqueness: true
  validates :address, presence: true, length: { in: 4..50 }
  
  # VALID_PHONE_REGEX = /\A(\+\d{1,2}\s)?\(?\d{3}\)?[\s.-]\d{3}[\s.-]\d{4}\z/i
  # validates :phone, presence: true, length: { in: 4..20 }, 
  #                   format: { with: VALID_PHONE_REGEX }
                    
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { in: 4..20 }, 
                    format: { with: VALID_EMAIL_REGEX }
  
  before_save :downcase_address
  
  private
  
  def downcase_address
    self.address = address.downcase
  end
end
