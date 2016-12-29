class Type < ActiveRecord::Base
  has_many :items
  validates :title, presence: true, length: { in: 5..13 }, uniqueness: true   
end
