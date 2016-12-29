class Item < ActiveRecord::Base
  mount_uploader :image, AvatarUploader
  
  belongs_to :type
  has_many :weekdays, as: :daily_menu
  
  validates :title, presence: true, length: { in: 4..60 }, uniqueness: true
  validates :price, presence: true, numericality: { only_float: true }
  
  after_save :link_to_weekday
  
  private
  
  def create
    super
    self.types << Type.find_by_id(attributes['type_id'])
  end
  
  def link_to_weekday
    self.weekdays << Weekday.find_by_order_number(Time.now.wday)
  end
  
  def reject_types attributes
    attributes['type_id'].empty?
  end    
end
