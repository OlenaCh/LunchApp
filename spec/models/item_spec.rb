require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'validate a new item' do
    it 'has a valid factory' do
      expect(FactoryGirl.build(:item)).to be_valid
    end
    
    it 'requires a type' do
      expect(FactoryGirl.build(:item, item_type: '')).to be_invalid
    end

    it 'requires a title' do
      expect(FactoryGirl.build(:item, title: '')).to be_invalid
    end

    it 'requires a title no shorter than 4 symbols' do
      expect(FactoryGirl.build(:item, title: 'a' * 3)).to be_invalid
    end

    it 'requires a title no longer than 60 symbols' do
      expect(FactoryGirl.build(:item, title: 'a' * 61)).to be_invalid
    end
    
    it 'requires a price' do
      expect(FactoryGirl.build(:item, price: '')).to be_invalid
    end

    it 'requires a numeric price' do
      expect(FactoryGirl.build(:item, price: 'twenty')).to be_invalid
      expect(FactoryGirl.build(:item, price: '20.0')).to be_valid
    end

    it 'has many order_items' do
      expect(Item.reflect_on_association(:order_items).macro).to eq :has_many
    end

    it 'has many orders' do
      expect(Item.reflect_on_association(:orders).macro).to eq :has_many
    end

    it 'has many menus' do
      expect(Item.reflect_on_association(:menus).macro).to eq :has_and_belongs_to_many
    end
    
    context '#First Courses' do
      before(:each) { FactoryGirl.create_list(:item, 3, item_type: 'First course') }
      
      it 'returns array of items with type \'First Course\'' do
        expect(Item.first_courses.length).to eq 3
      end
    end
    
    context '#Main Courses' do
      before(:each) { FactoryGirl.create_list(:item, 4, item_type: 'Main course') }
      
      it 'returns array of items with type \'Main Course\'' do
        expect(Item.main_courses.length).to eq 4
      end
    end
    
    context '#Drinks' do
      before(:each) { FactoryGirl.create_list(:item, 2, item_type: 'Drink') }
      
      it 'returns array of items with type \'Drink\'' do
        expect(Item.drinks.length).to eq 2
      end
    end
  end
end