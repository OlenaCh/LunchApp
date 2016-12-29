require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'validate a new item' do
    it "has valid factory" do
      expect(FactoryGirl.build(:item)).to be_valid
    end

    it "requires a title" do
      expect(FactoryGirl.build(:item, :title => "")).to be_invalid
    end

    it "requires a title no shorter than 4 symbols" do
      expect(FactoryGirl.build(:item, :title => "a" * 3)).to be_invalid
    end

    it "requires a title no longer than 60 symbols" do
      expect(FactoryGirl.build(:item, :title => "a" * 61)).to be_invalid
    end
    
    it "requires a price" do
      expect(FactoryGirl.build(:item, :price => "")).to be_invalid
    end

    it "requires a numeric price" do
      expect(FactoryGirl.build(:item, :price => "twenty")).to be_invalid
      expect(FactoryGirl.build(:item, :price => "20.0")).to be_valid
    end
    
    context 'has_many associations' do
      it "can have one and more types" do
        Item.any_instance.stub(:link_to_weekday).and_return(true)
        item = FactoryGirl.create(:item)
        type = FactoryGirl.create(:type)
        item.types << type
        expect(item.types).to eq([type])
      end

      it "can have one and more weekdays" do
        Item.any_instance.stub(:link_to_weekday).and_return(true)
        item = FactoryGirl.create(:item)
        weekday = FactoryGirl.create(:weekday)
        item.weekdays << weekday
        expect(item.weekdays).to eq([weekday])
      end
    end
  end
end