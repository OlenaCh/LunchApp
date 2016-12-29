require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let!(:user1) {
    user1 = FactoryGirl.create(:user) 
  }

  describe 'admin\'s paths' do
    before(:each) do
      admin = FactoryGirl.create(:admin)
      allow(request.env['warden']).to receive(:authenticate!).and_return(admin)
      allow(controller).to receive(:current_user).and_return(admin)
    end

    # describe 'GET #index' do
    #   it 'renders all users in database' do
    #     user2 = FactoryGirl.create(:user)
    #     get :index
    #     expect(response.body).to have_content([user1, user2])
    #   end

    #   it 'renders all products in database by price' do
    #     another_one = Product.create(:title => 'Indian Tea', :short_description => 'Green tea',
    #                                  :long_description => 'Very tasty tea', :price => '30.0')
    #     get :index, sort: 'price'
    #     expect(JSON.parse(response.body).to_json).to have_content([another_one, product].to_json)
    #   end
    # end
  end

  describe 'authenticated user\'s paths' do
    before(:each) do
      user = FactoryGirl.create(:user)
      allow(request.env['warden']).to receive(:authenticate!).and_return(user)
      allow(controller).to receive(:current_user).and_return(user)
    end

    describe 'GET #index' do
      it 'responds with HTTP status 302' do
        get :index
        expect(response.status).to eq 302
      end

      it 'redirects to inform that this page is for admins only' do
        get :index
        expect(response).to redirect_to not_admins_path
      end
    end
  end

  describe 'random visitor\'s paths' do
    before(:each) do
      allow(request.env['warden']).to receive(:authenticate!).and_throw(:warden, {:scope => :user})
    end

    describe 'GET #index' do
      it 'responds with HTTP status 302' do
        get :index
        expect(response.status).to eq 302
      end

      it 'redirects to log in page' do
        get :index
        expect(response).to redirect_to new_user_session_path
      end
      
      it 'flashes that there is a need to sign in or sign up before continuing' do
        get :index
        expect(flash[:alert]).to be_present
      end
    end
  end
end