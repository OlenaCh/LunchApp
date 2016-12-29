require 'rails_helper'

RSpec.describe User, type: :model do 
  describe 'validate a new user' do
    it "should have valid factory" do
      expect(FactoryGirl.build(:user)).to be_valid
    end

    it "should require a username" do
      expect(FactoryGirl.build(:user, :name => "")).to be_invalid
    end

    it "should require a username no longer than 40 symbols" do
      expect(FactoryGirl.build(:user, :name => "a" * 41)).to be_invalid
    end
    
    context 'has_many associations' do
      it "can have one and more order" do
        user = FactoryGirl.create(:user)
        Order.any_instance.stub(:link_to_weekday).and_return(true)
        order1 = user.orders.create!(first_course_id: 1, main_course_id: 2, drink_id: 5, total: 10.0)
        order2 = user.orders.create!(first_course_id: 3, main_course_id: 4, drink_id: 6, total: 15.0)
        expect(user.orders).to eq([order1, order2])
      end
    end
  end
end