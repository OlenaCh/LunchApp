require 'rails_helper'

RSpec.describe Menu, type: :model do
  describe 'validate a new menu' do
    it 'has a valid factory' do
      expect(FactoryGirl.build(:menu)).to be_valid
    end
    
    it 'has many items' do
      expect(Menu.reflect_on_association(:items).macro).to eq :has_and_belongs_to_many
    end
    
    it 'requires a weekday' do
      expect(FactoryGirl.build(:menu, weekday: '')).to be_invalid
    end
  end
end