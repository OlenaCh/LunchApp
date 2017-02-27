require 'rails_helper'

RSpec.describe OrdersController, type: :controller do
  let(:order) { FactoryGirl.create(:order) }
  let(:order_params) { FactoryGirl.attributes_for(:order) }

  describe 'ADMIN' do
    before(:each) do
      admin = FactoryGirl.create(:admin)
      allow(request.env['warden']).to receive(:authenticate!).and_return(admin)
      allow(controller).to receive(:current_admin).and_return(admin)
    end
    
    # Actions that cannot be accessed by admin
    
    shared_examples 'redirection to users only path' do
      it 'redirects to users only path' do
        expect(response).to redirect_to users_only_path
      end
      
      it 'responds with HTTP status 302' do
        expect(response.status).to eq 302
      end
    end
    
    describe 'GET #new' do
      before(:each) { get :new }
        
      it_behaves_like 'redirection to users only path'
    end

    describe 'POST #create' do
      it 'does not create a new order' do
        expect { post :create, order: order_params }.to change(Order, :count).by(0)
      end
      
      context 'redirection' do
        before(:each) { post :create, order: order_params }
        
        it_behaves_like 'redirection to users only path'
      end
    end
    
    describe 'GET #show' do
      before(:each) { get :show, id: order, format: 'pdf' }
      
      it 'does not return an order in pdf' do
        expect(response.headers['Content-Type']).not_to eq('application/pdf')
      end
      
      it_behaves_like 'redirection to users only path'
    end
    
    # Actions that can be accessed by admin
    
    describe 'GET #index' do
      it 'renders index page' do
        get :index        
        expect(response).to render_template(:index)
      end
    end
    
    describe 'PUT #update' do
      before(:each) do
        put :update, id: order, order: { status: 'Delivered' }, format: 'json'
      end
      
      it 'updates order record' do
        expect(Order.find_by_id(order.id).status).to eq('Delivered')
      end
      
      it 'responds with HTTP status 200' do
        expect(response.status).to eq 200
      end
    end
  end

  describe 'UNAUTHORIZED USER' do
    before(:each) do
      allow(request.env['warden']).to receive(:authenticate!).and_throw(:warden, {:scope => :admin})
    end
    
    # Actions that cannot be accessed by unauthorized user 
    
    shared_examples 'unauthorized_user' do
      it 'responds with HTTP status 302' do
        expect(response.status).to eq 302
      end
      
      it 'redirects to unauthorized page' do
        expect(response).to redirect_to unauthorized_path
      end
    end
    
    describe 'GET #index' do
      before(:each) { get :index }
      
      it_behaves_like 'unauthorized_user'
    end

    describe 'PUT #update' do
      before(:each) { put :update, id: order, order: order_params }
      
      it_behaves_like 'unauthorized_user'
    end
    
    # Actions that can be accessed by unauthorized user
    
    describe 'GET #new' do
      it 'renders new template if no billed order is passed' do
        get :new, items_ids: [1, 2]
        expect(response).to render_template(:new)
      end
      
      it 'renders thank you template if a billed order is passed' do
        get :new, billed_order: 1
        expect(response).to render_template(:thank_you)
      end
    end
    
    describe 'POST #create' do
      it 'creates a new order' do
        expect { post :create, order: order_params }.to change(Order, :count).by(1)
      end
      
      context 'redirection' do
        before(:each) { post :create, order: order_params }
        
        it 'assigns status CONFIRMED to a new order' do
          expect(Order.last.status).to eq('Confirmed')
        end
        
        it 'redirects to new order page' do
          expect(response).to redirect_to new_order_path(billed_order: Order.last.id)
        end
        
        it 'responds with HTTP status 302' do
          expect(response.status).to eq 302
        end
      end
    end
    
    describe 'GET #show' do
      it 'returns an order in pdf' do
        get :show, id: order, format: 'pdf'
        expect(response.headers['Content-Type']).to eq('application/pdf')
      end
    end
  end
end