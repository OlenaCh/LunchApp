require 'rails_helper'

RSpec.describe Type, type: :model do
  describe 'validate a new type' do
    it "has valid factory" do
      expect(FactoryGirl.build(:type)).to be_valid
    end

    it "should require a title" do
      expect(FactoryGirl.build(:type, :title => "")).to be_invalid
    end
    
    it "should require a title no shorter than 5 symbols" do
      expect(FactoryGirl.build(:type, :title => "a" * 4)).to be_invalid
    end

    it "should require a title no longer than 13 symbols" do
      expect(FactoryGirl.build(:type, :title => "a" * 16)).to be_invalid
    end
    
    it "validates uniqueness of title" do
      Type.create!(:title => 'Dessert')
      type = Type.new(:title => 'Dessert')
      expect(type).to be_invalid
    end
    
    context 'has_many associations' do
      it "can have one and more items" do
        Item.any_instance.stub(:link_to_weekday).and_return(true)
        type = FactoryGirl.create(:type)
        item1 = FactoryGirl.create(:item) 
        item2 = FactoryGirl.create(:item)
        type.items << item1
        type.items << item2
        expect(type.items).to eq([item1, item2])
      end
    end
  end
end