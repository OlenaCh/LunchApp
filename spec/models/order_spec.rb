require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'validate a new order' do
    it "has valid factory" do
      expect(FactoryGirl.build(:order)).to be_valid
    end

    it "requires a name" do
      expect(FactoryGirl.build(:order, :name => "")).to be_invalid
    end

    it "requires a name no shorter than 10 symbols" do
      expect(FactoryGirl.build(:order, :name => "a" * 9)).to be_invalid
    end

    it "requires a name no longer than 50 symbols" do
      expect(FactoryGirl.build(:order, :name => "a" * 51)).to be_invalid
    end
    
    it "requires an address" do
      expect(FactoryGirl.build(:order, :address => "")).to be_invalid
    end

    it "requires an address no shorter than 10 symbols" do
      expect(FactoryGirl.build(:order, :address => "a" * 9)).to be_invalid
    end

    it "requires an address no longer than 60 symbols" do
      expect(FactoryGirl.build(:order, :address => "a" * 61)).to be_invalid
    end
    
    it "requires a status" do
      expect(FactoryGirl.build(:order, :status => "")).to be_invalid
    end
    
    it "has many order_items" do
      expect(Order.reflect_on_association(:order_items).macro).to eq :has_many
    end

    it "has many orders" do
      expect(Order.reflect_on_association(:items).macro).to eq :has_many
    end
  end
end