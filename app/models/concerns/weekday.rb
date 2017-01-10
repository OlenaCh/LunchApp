require 'active_support/concern'

module Weekday
  extend ActiveSupport::Concern
  included do
    def self.weekdays
      {
         MON: 'Monday', TUE: 'Tuesday', WED: 'Wednesday', THU: 'Thursday',
         FRI: 'Friday', SAT: 'Saturday', SUN: 'Sunday'
      }.freeze
    end
  end
end