class Order < ActiveRecord::Base
  belongs_to :user
  has_many :weekdays, as: :daily_order    
  
  validates :first_course_id, presence: true, 
                              numericality: { only_integer: true }
  validates :main_course_id, presence: true, 
                             numericality: { only_integer: true }
  validates :drink_id, presence: true, numericality: { only_integer: true }
 
  after_save :link_to_weekday
  
  def self.first_courses_for_today
    Item.includes(:types, :weekdays).where(:types => { :id => Type.find_by_title(
                  'First course').id }, :weekdays => { :order_number => Time.now.wday + 1 })
  end
  
  def self.main_courses_for_today
    Item.includes(:types, :weekdays).where(:types => { :id => Type.find_by_title(
                  'Main course').id }, :weekdays => { :order_number => Time.now.wday + 1 })
  end
  
  def self.drinks_for_today
    Item.includes(:types, :weekdays).where(:types => { :id => Type.find_by_title(
                  'Drink').id }, :weekdays => { :order_number => Time.now.wday + 1 })
  end
  
  private
  
  def link_to_weekday
    self.weekdays << Weekday.find_by_order_number(Time.now.wday)
  end    
end