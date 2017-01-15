class Item < ActiveRecord::Base
  include ItemType
  mount_uploader :image, AvatarUploader
  
  validates :title, presence: true, length: { in: 4..60 }, uniqueness: true
  validates :price, presence: true, numericality: { only_float: true }
  
  scope :first_courses, -> { where("item_type == 'first_course'") }
  scope :main_courses, -> { where("item_type == 'main_course'") }
  scope :drinks, -> { where("item_type == 'drink'") }
end
