require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'validate a new order' do
    it "has valid factory" do
      expect(FactoryGirl.build(:order)).to be_valid
    end

    it "requires a first course id" do
      expect(FactoryGirl.build(:order, :first_course_id => "")).to be_invalid
    end

    it "requires a numeric first course id" do
      expect(FactoryGirl.build(:order, :first_course_id => "one")).to be_invalid
      expect(FactoryGirl.build(:order, :first_course_id => 1.0)).to be_invalid
      expect(FactoryGirl.build(:order, :first_course_id => 1)).to be_valid
    end
    
    it "requires a main course id" do
      expect(FactoryGirl.build(:order, :main_course_id => "")).to be_invalid
    end

    it "requires a numeric main course id" do
      expect(FactoryGirl.build(:order, :main_course_id => "one")).to be_invalid
      expect(FactoryGirl.build(:order, :main_course_id => 1.0)).to be_invalid
      expect(FactoryGirl.build(:order, :main_course_id => 1)).to be_valid
    end
    
    it "requires a drink id" do
      expect(FactoryGirl.build(:order, :drink_id => "")).to be_invalid
    end

    it "requires a numeric drink id" do
      expect(FactoryGirl.build(:order, :drink_id => "one")).to be_invalid
      expect(FactoryGirl.build(:order, :drink_id => 1.0)).to be_invalid
      expect(FactoryGirl.build(:order, :drink_id => 1)).to be_valid
    end
    
    context 'has_many associations' do
      it "can have one and more weekdays" do
        Order.any_instance.stub(:link_to_weekday).and_return(true)
        order = FactoryGirl.create(:order)
        weekday = FactoryGirl.create(:weekday)
        order.weekdays << weekday
        expect(order.weekdays).to eq([weekday])
      end
    end
  end    
end