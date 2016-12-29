require 'rails_helper'

RSpec.describe Weekday, type: :model do
  describe 'validate a new week day' do
    it "has valid factory" do
      expect(FactoryGirl.build(:weekday)).to be_valid
    end

    it "should require a day" do
      expect(FactoryGirl.build(:weekday, :day => "")).to be_invalid
    end
    
    it "should require a day no shorter than 6 symbols" do
      expect(FactoryGirl.build(:weekday, :day => "a" * 5)).to be_invalid
    end

    it "should require a day no longer than 10 symbols" do
      expect(FactoryGirl.build(:weekday, :day => "a" * 11)).to be_invalid
    end
    
    it "validates uniqueness of day" do
      Weekday.create!(:day => 'Weekday', :order_number => 2)
      day = Weekday.new(:day => 'Weekday', :order_number => 3)
      expect(day).to be_invalid
    end
    
    it "should require an order number" do
      expect(FactoryGirl.build(:weekday, :order_number => "")).to be_invalid
    end
    
    it "should require an order number no less than 0" do
      expect(FactoryGirl.build(:weekday, :order_number => -1)).to be_invalid
    end

    it "should require an order number no greater than 6" do
      expect(FactoryGirl.build(:weekday, :order_number => 7)).to be_invalid
    end
    
    it "should require an order number to be integer" do
      expect(FactoryGirl.build(:weekday, :order_number => 'one')).to be_invalid
    end
    
    it "validates uniqueness of order number" do
      Weekday.create!(:day => 'Weekday', :order_number => 2)
      day = Weekday.new(:day => 'aWeekday', :order_number => 2)
      expect(day).to be_invalid
    end
    
    context 'has_many associations' do
      it "can have one and more items" do
        Item.any_instance.stub(:link_to_weekday).and_return(true)
        weekday = FactoryGirl.create(:weekday)
        item1 = FactoryGirl.create(:item)
        item2 = FactoryGirl.create(:item)
        weekday.items << item1
        weekday.items << item2
        expect(weekday.items).to eq([item1, item2])
      end
      
      it "can have one and more orders" do
        Order.any_instance.stub(:link_to_weekday).and_return(true)
        weekday = FactoryGirl.create(:weekday)
        order1 = FactoryGirl.create(:order)
        order2 = FactoryGirl.create(:order)
        weekday.orders << order1
        weekday.orders << order2
        expect(weekday.orders).to eq([order1, order2])
      end
    end
  end
end