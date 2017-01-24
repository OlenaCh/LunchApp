class Menu < ActiveRecord::Base
  include Weekday
  has_and_belongs_to_many :items
end
