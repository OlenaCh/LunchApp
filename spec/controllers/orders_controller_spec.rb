require 'rails_helper'

RSpec.describe OrdersController, type: :controller do
  let!(:order) {
    Order.any_instance.stub(:link_to_weekday).and_return(true)   
    order = FactoryGirl.create(:order)
  }

  let!(:order_params) {
    order_params = FactoryGirl.attributes_for(:order)
  }

  describe 'admin\'s paths' do
    before(:each) do
      admin = FactoryGirl.create(:admin)
      allow(request.env['warden']).to receive(:authenticate!).and_return(admin)
      allow(controller).to receive(:current_user).and_return(admin)
    end
    
    describe 'GET #new' do
      it 'responds with HTTP status 302' do
        get :new
        expect(response.status).to eq 302
      end

      it 'renders that this page is for users only' do
        get :new
        expect(response).to redirect_to not_users_path
      end
    end
    
    describe 'GET #index' do
      it 'renders index page' do
        get :index        
        expect(response).to render_template(:index)
      end
    end
    
    describe 'GET #today_index' do
      it 'renders today index page' do
        get :today_index        
        expect(response).to render_template(:today_index)
      end
    end

    describe 'POST #create' do
      it 'does not create a new order' do
        expect { post :create, :order => order_params }.to change(Order, :count).by(0)
      end
      
      it 'responds with HTTP status 302' do
        post :create, :order => order_params
        expect(response.status).to eq 302
      end

      it 'renders that this page is for users only' do
        post :create, :order => order_params
        expect(response).to redirect_to not_users_path
      end
    end
    
    describe 'GET #show' do
      it 'renders show page' do
        get :show, :id => order        
        expect(response).to render_template(:show)
      end
    end
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

      it 'renders that this page is for admins only' do
        get :index
        expect(response).to redirect_to not_admins_path
      end
    end
    
    describe 'GET #today_index' do
      it 'responds with HTTP status 302' do
        get :today_index
        expect(response.status).to eq 302
      end

      it 'renders that this page is for admins only' do
        get :today_index
        expect(response).to redirect_to not_admins_path
      end
    end

    describe 'POST #create' do
      context 'with valid params' do
        it 'creates a new order' do
          allow(controller).to receive(:count_total).and_return(10.0)
          expect { post :create, :order => order_params }.to change(Order, :count).by(1)
        end
          
        it 'responds with HTTP status 302' do
          allow(controller).to receive(:count_total).and_return(10.0)
          post :create, :order => order_params
          expect(response.status).to eq 302
        end
    
        it 'redirects to the items path' do
          allow(controller).to receive(:count_total).and_return(10.0)
          post :create, :order => order_params
          expect(response).to redirect_to items_path
        end
        
        it 'flashes about creation success' do
          allow(controller).to receive(:count_total).and_return(10.0)
          post :create, :order => order_params
          expect(flash[:success]).to be_present
        end
      end

      context 'with invalid params' do
        it 'does not create a new order' do
          allow(controller).to receive(:count_total).and_return(10.0)    
          expect { post :create, :order => order_params.merge({drink_id: ''}) }.to change(Order, :count).by(0)
        end
          
        it 'responds with alert message' do
          allow(controller).to receive(:count_total).and_return(10.0)
          post :create, :order => order_params.merge({drink_id: ''})
          expect(flash[:alert]).to be_present
        end
    
        it 'renders new order page' do
          allow(controller).to receive(:count_total).and_return(10.0)
          post :create, :order => order_params.merge({drink_id: ''})
          expect(response).to render_template(:new)
        end
      end
    end
    
    describe 'GET #show' do
      it 'responds with HTTP status 302' do
        get :show, :id => order
        expect(response.status).to eq 302
      end

      it 'renders that this page is for admins only' do
        get :show, :id => order
        expect(response).to redirect_to not_admins_path
      end
    end
  end

  describe 'random visitor\'s paths' do
    before(:each) do
      allow(request.env['warden']).to receive(:authenticate!).and_throw(:warden, {:scope => :user})
    end
    
    describe 'GET #new' do
      it 'responds with HTTP status 302' do
        get :new
        expect(response.status).to eq 302
      end

      it 'redirects to log in page' do
        get :new
        expect(response).to redirect_to new_user_session_path
      end
      
      it 'flashes that there is a need to sign in or sign up before continuing' do
        get :new
        expect(flash[:alert]).to be_present
      end
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
    
    describe 'GET #today_index' do
      it 'responds with HTTP status 302' do
        get :today_index
        expect(response.status).to eq 302
      end

      it 'redirects to log in page' do
        get :today_index
        expect(response).to redirect_to new_user_session_path
      end
      
      it 'flashes that there is a need to sign in or sign up before continuing' do
        get :today_index
        expect(flash[:alert]).to be_present
      end
    end

    describe 'POST #create' do
      it 'does not create a new order' do
        expect { post :create, :order => order_params }.to change(Order, :count).by(0)
      end
        
      it 'responds with HTTP status 302' do
        post :create, :order => order_params
        expect(response.status).to eq 302
      end

      it 'redirects to log in page' do
        post :create, :order => order_params
        expect(response).to redirect_to new_user_session_path
      end
      
      it 'flashes that there is a need to sign in or sign up before continuing' do
        post :create, :order => order_params
        expect(flash[:alert]).to be_present
      end
    end
    
    describe 'GET #show' do
      it 'responds with HTTP status 302' do
        get :show, :id => order
        expect(response.status).to eq 302
      end

      it 'redirects to log in page' do
        get :show, :id => order
        expect(response).to redirect_to new_user_session_path
      end
      
      it 'flashes that there is a need to sign in or sign up before continuing' do
        get :show, :id => order
        expect(flash[:alert]).to be_present
      end
    end
  end
end