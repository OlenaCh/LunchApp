class Item < ActiveRecord::Base
  mount_uploader :image, AvatarUploader
  
  belongs_to :type
  
  validates :title, presence: true, length: { in: 4..60 }, uniqueness: true
  validates :price, presence: true, numericality: { only_float: true }
end
