require 'rails_helper'

RSpec.describe MenusController, type: :controller do
  let(:menu) { FactoryGirl.create(:menu) }
  let(:menu_params) { FactoryGirl.attributes_for(:menu) }

  describe 'ADMIN' do
    before(:each) do
      admin = FactoryGirl.create(:admin)
      allow(request.env['warden']).to receive(:authenticate!).and_return(admin)
      allow(controller).to receive(:current_admin).and_return(admin)
    end
    
    shared_examples 'redirection to index page' do
      it 'redirects to index page' do
        expect(response).to redirect_to menus_path
      end
      
      it 'responds with HTTP status 302' do
        expect(response.status).to eq 302
      end
    end
    
    describe 'POST #create' do
      context 'with valid params' do
        it 'creates a new product' do
          expect { post :create, :menu => menu_params }.to change(Menu, :count).by(1)
        end
        
        context 'redirection' do
          before(:each) { post :create, :menu => menu_params }
          
          it_behaves_like 'redirection to index page'
        end
      end

      context 'with invalid params' do
        # it 'does not create a new menu' do  
        #   expect { post :create, :menu => nil }.to change(Menu, :count).by(0)
        # end
          
        # it 'renders new template' do 
        #   post :create, :menu => nil
        #   expect(response).to render_template(:new)
        # end
        
        # it 'does not respond with flash message' do 
        #   post :create, :menu => nil
        #   expect(response.status).not_to eq 302
        # end
      end
    end

    describe 'PUT #update' do
      context 'with valid params' do
        before(:each) { put :update, :id => menu, :menu => menu_params }
          
        it_behaves_like 'redirection to index page'
      end

      context 'with invalid params' do
        # before(:each) { put :update, :id => menu, :item => menu_params }
        
        # it 'renders edit page' do
        #   expect(response).to render_template(:edit)
        # end
      
        # it 'does not respond with HTTP status 302' do
        #   expect(response.status).not_to eq 302
        # end
      end
    end

    describe 'GET #new' do
      it 'renders new page' do
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

    describe 'GET #edit' do
      it 'renders an existing item' do
        get :edit, :id => menu.id
        expect(response).to render_template(:edit)
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

    describe 'POST #create' do
      it 'does not create a new menu' do
        expect { post :create, :menu => menu_params }.to change(Menu, :count).by(0)
      end
      
      context 'redirection' do
        before(:each) { post :create, :menu => menu_params }
        
        it_behaves_like 'unauthorized_user'
      end
    end

    describe 'GET #edit' do
      before(:each) { get :edit, :id => menu }
      
      it_behaves_like 'unauthorized_user'
    end

    describe 'PUT #update' do
      before(:each) { put :update, :id => menu, :menu => menu_params }
      
      it_behaves_like 'unauthorized_user'
    end
    
    # Actions that can be accessed by unauthorized user 
    
    describe 'GET #index' do
      it 'renders index page' do
        get :index
        expect(response).to render_template(:index)
      end
    end
  end
end