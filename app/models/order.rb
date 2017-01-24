class Order < ActiveRecord::Base
  belongs_to :user
  
  # validates :first_course_id, presence: true, 
  #                             numericality: { only_integer: true }
  # validates :main_course_id, presence: true, 
  #                           numericality: { only_integer: true }
  # validates :drink_id, presence: true, numericality: { only_integer: true }
  
end