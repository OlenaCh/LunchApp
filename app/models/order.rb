class Order < ActiveRecord::Base
  has_many :order_items, inverse_of: :order
  has_many :items, through: :order_items
  
  accepts_nested_attributes_for :order_items
  
  validates :name,    presence: true, length: { in: 10..50 } 
  validates :address, presence: true, length: { in: 10..60 }
  validates :status,  presence: true
end