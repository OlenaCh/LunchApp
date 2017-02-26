require 'rails_helper'

RSpec.describe MenusController, type: :controller do
  let(:menu) { FactoryGirl.create(:menu) }
  let(:menu_params) { FactoryGirl.attributes_for(:menu) }

  describe 'admin\'s paths' do
    before(:each) do
      admin = FactoryGirl.create(:admin)
      allow(request.env['warden']).to receive(:authenticate!).and_return(admin)
      allow(controller).to receive(:current_admin).and_return(admin)
    end
    
    describe 'GET #new' do
      it 'renders that this page is for users only' do
        get :new
        expect(response).to render_template(:new)
      end
    end
    
    describe 'GET #index' do
      it 'renders index page' do
        get :index        
        expect(response).to render_template(:index)
      end
    end
    
    describe 'POST #create' do
      # it 'does not create a new order' do
      #   expect { post :create, :order => order_params }.to change(Order, :count).by(0)
      # end
      
      # it 'responds with HTTP status 302' do
      #   post :create, :order => order_params
      #   expect(response.status).to eq 302
      # end

      # it 'renders that this page is for users only' do
      #   post :create, :order => order_params
      #   expect(response).to redirect_to not_users_path
      # end
    end
  end

  # describe 'random visitor\'s paths' do
  #   before(:each) do
  #     allow(request.env['warden']).to receive(:authenticate!).and_throw(:warden, {:scope => :user})
  #   end
    
  #   describe 'GET #new' do
  #     it 'responds with HTTP status 302' do
  #       get :new
  #       expect(response.status).to eq 302
  #     end

  #     it 'redirects to log in page' do
  #       get :new
  #       expect(response).to redirect_to new_user_session_path
  #     end
      
  #     it 'flashes that there is a need to sign in or sign up before continuing' do
  #       get :new
  #       expect(flash[:alert]).to be_present
  #     end
  #   end

  #   describe 'GET #index' do
  #     it 'responds with HTTP status 302' do
  #       get :index
  #       expect(response.status).to eq 302
  #     end

  #     it 'redirects to log in page' do
  #       get :index
  #       expect(response).to redirect_to new_user_session_path
  #     end
      
  #     it 'flashes that there is a need to sign in or sign up before continuing' do
  #       get :index
  #       expect(flash[:alert]).to be_present
  #     end
  #   end

  #   describe 'POST #create' do
  #     it 'does not create a new order' do
  #       expect { post :create, :order => order_params }.to change(Order, :count).by(0)
  #     end
        
  #     it 'responds with HTTP status 302' do
  #       post :create, :order => order_params
  #       expect(response.status).to eq 302
  #     end

  #     it 'redirects to log in page' do
  #       post :create, :order => order_params
  #       expect(response).to redirect_to new_user_session_path
  #     end
      
  #     it 'flashes that there is a need to sign in or sign up before continuing' do
  #       post :create, :order => order_params
  #       expect(flash[:alert]).to be_present
  #     end
  #   end
  # end
end