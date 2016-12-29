class Weekday < ActiveRecord::Base
  belongs_to :daily_menu, polymorphic: true
  belongs_to :daily_order, polymorphic: true
  
  validates :day, presence: true, length: { in: 6..10 }, uniqueness: true 
end