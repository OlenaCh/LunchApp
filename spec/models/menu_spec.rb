require 'rails_helper'

RSpec.describe Menu, type: :model do
  describe 'validate a new menu' do
    it "has valid factory" do
      expect(FactoryGirl.build(:menu)).to be_valid
    end

    # it "requires a title" do
    #   expect(FactoryGirl.build(:item, :title => "")).to be_invalid
    # end

    # it "requires a title no shorter than 4 symbols" do
    #   expect(FactoryGirl.build(:item, :title => "a" * 3)).to be_invalid
    # end

    # it "requires a title no longer than 60 symbols" do
    #   expect(FactoryGirl.build(:item, :title => "a" * 61)).to be_invalid
    # end
    
    # it "requires a price" do
    #   expect(FactoryGirl.build(:item, :price => "")).to be_invalid
    # end

    # it "requires a numeric price" do
    #   expect(FactoryGirl.build(:item, :price => "twenty")).to be_invalid
    #   expect(FactoryGirl.build(:item, :price => "20.0")).to be_valid
    # end
  end
end