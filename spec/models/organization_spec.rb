require 'rails_helper'

RSpec.describe Organization, type: :model do
  describe 'validate a new organization' do
    it "has valid factory" do
      expect(FactoryGirl.build(:organization)).to be_valid
    end

    it "should require a title" do
      expect(FactoryGirl.build(:organization, :title => "")).to be_invalid
    end
    
    it "should require a title no shorter than 4 symbols" do
      expect(FactoryGirl.build(:organization, :title => "a" * 3)).to be_invalid
    end

    it "should require a title no longer than 30 symbols" do
      expect(FactoryGirl.build(:organization, :title => "a" * 31)).to be_invalid
    end
    
    it "validates uniqueness of title" do
      Organization.create!(:title => 'TeaShop', :address => 'Lviv', 
                          :email => 'teashop@gmail.com', :phone => '230-00-07')
      organization = Organization.new(:title => 'TeaShop', :address => 'Kyiv', 
                          :email => 'teashop2@gmail.com', :phone => '230-00-07')
      expect(organization).to be_invalid
    end
    
    it "should require an address" do
      expect(FactoryGirl.build(:organization, :address => "")).to be_invalid
    end
    
    it "should require an address no shorter than 4 symbols" do
      expect(FactoryGirl.build(:organization, :address => "a" * 3)).to be_invalid
    end

    it "should require an address no longer than 50 symbols" do
      expect(FactoryGirl.build(:organization, :address => "a" * 51)).to be_invalid
    end
    
    it "triggers downcase_address on save" do
      organization = FactoryGirl.create(:organization)
      expect(organization).to receive(:downcase_address)
      expect(organization[:address]).to match(/[^A-Z]/)
      organization.save
    end
    
    it "should require an email with a certain format" do
      expect(FactoryGirl.build(:organization, :email => "lviv.com.ua")).to be_invalid
      expect(FactoryGirl.build(:organization, :email => "lviv@com")).to be_invalid
      expect(FactoryGirl.build(:organization, :email => "lviv@com.ua")).to be_valid
    end
    
    context 'has_many associations' do
      it "can have one and more user" do
        organization = FactoryGirl.create(:organization)
        user1 = organization.users.create!(name: 'Volodya', email: 'volodya@gmail.com', password: '11111111')
        user2 = organization.users.create!(name: 'Olena', email: 'olena@gmail.com', password: '21111111')
        expect(organization.users).to eq([user2, user1])
      end
    end
  end    
end