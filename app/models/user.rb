class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :validatable, :omniauthable, :omniauth_providers => [:google_oauth2]
         
  belongs_to :organization
  has_many :orders, dependent: :destroy
  
  validates :name, presence: true, length: { in: 2..40 }  
  
  after_create :set_admin
  
  def self.find_for_google_oauth2(access_token, signed_in_resource=nil)
    data = access_token['info']
    user = User.where(:provider => access_token.provider, :uid => access_token.uid ).first
    if user
      return user
    else
      registered_user = User.where(:email => access_token.info.email).first
      if registered_user
        return registered_user
      else
        user = User.create(name: data["name"],
          provider:access_token.provider,
          email: data["email"],
          uid: access_token.uid ,
          password: Devise.friendly_token[6,10],
        )
      end
    end
  end

  private
  
  def set_admin
    User.first.update_attribute(:admin, true) if  User.count == 1
  end
end