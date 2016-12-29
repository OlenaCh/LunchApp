require 'rails_helper'

RSpec.describe StaticPagesController, type: :controller do
  describe 'admin\'s paths' do
    before(:each) do
      admin = FactoryGirl.create(:admin)
      allow(request.env['warden']).to receive(:authenticate!).and_return(admin)
      allow(controller).to receive(:current_user).and_return(admin)
    end
      
    describe 'GET #admins_only' do
      it 'gets users only page' do
        get :users_only
        expect(response.status).to eq 200
      end
    end
  end
  
  describe 'authenticated user\'s paths' do
    before(:each) do
      user = FactoryGirl.create(:user)
      allow(request.env['warden']).to receive(:authenticate!).and_return(user)
      allow(controller).to receive(:current_user).and_return(user)
    end
      
    describe 'GET #admins_only' do
      it 'gets admins only page' do
        get :admins_only
        expect(response.status).to eq 200
      end
    end
  end
  
  describe 'random visitor\'s paths' do
    before(:each) do
      allow(request.env['warden']).to receive(:authenticate!).and_throw(:warden, {:scope => :user})
    end
      
    describe 'GET #admins_only' do
      it 'does not get admins only page' do
        get :admins_only
        expect(response.status).to eq 302
      end
      
      it 'redirects to log in page' do
        get :admins_only
        expect(response).to redirect_to new_user_session_path
      end
    end
    
    describe 'GET #admins_only' do
       it 'does not get users only page' do
        get :users_only
        expect(response.status).to eq 302
      end
      
      it 'redirects to log in page' do
        get :users_only
        expect(response).to redirect_to new_user_session_path
      end
    end
    
    describe 'GET #index' do
      it 'gets index page' do
        get :index
        expect(response.status).to eq 200
      end
    end
  end
end