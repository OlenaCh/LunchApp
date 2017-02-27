require 'rails_helper'

RSpec.describe Admin, type: :model do 
  describe 'validate a new admin' do
    it "should have valid factory" do
      expect(FactoryGirl.build(:admin)).to be_valid
    end
  end
end