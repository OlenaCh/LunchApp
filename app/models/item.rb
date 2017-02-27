class Item < ActiveRecord::Base
  include ItemType
  has_many :order_items
  has_many :orders, through: :order_items
  has_and_belongs_to_many :menus
  
  mount_uploader :image, ImageUploader
  
  validates :item_type, presence: true
  validates :title,     presence: true, length: { in: 4..60 }, uniqueness: true
  validates :price,     presence: true, numericality: { only_float: true }
  
  paginates_per 4
  
  scope :first_courses, -> { where(item_type: 'First course') }
  scope :main_courses, ->  { where(item_type: 'Main course') }
  scope :drinks, ->        { where(item_type: 'Drink') }
end
