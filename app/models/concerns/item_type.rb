require 'active_support/concern'

module ItemType
  extend ActiveSupport::Concern
  included do
    def self.types
      {
         FC: 'First course', MC: 'Main course', DR: 'Drink'
      }.freeze
    end
  end
end