require 'rails_helper'

RSpec.describe ItemsController, type: :controller do
  let(:item_params) { FactoryGirl.attributes_for(:item) }
  let!(:item) { FactoryGirl.create(:item) }

  describe 'ADMIN' do
    before(:each) do
      admin = FactoryGirl.create(:admin)
      allow(request.env['warden']).to receive(:authenticate!).and_return(admin)
      allow(controller).to receive(:current_admin).and_return(admin)
    end
    
    shared_examples 'redirection to index page' do
      it 'redirects to index page' do
        expect(response).to redirect_to items_path
      end
      
      it 'responds with HTTP status 302' do
        expect(response.status).to eq 302
      end
    end

    describe 'POST #create' do
      context 'with valid params' do
        it 'creates a new product' do
          expect { post :create, item: item_params }.to change(Item, :count).by(1)
        end
        
        context 'redirection' do
          before(:each) { post :create, item: item_params }
          
          it_behaves_like 'redirection to index page'
        end
      end

      context 'with invalid params' do
        before(:each) { controller.request.stub referer: '/items/new' }
        
        it 'does not create a new item' do  
          expect { post :create, item: item_params.merge({title: ''}) }.to change(Item, :count).by(0)
        end
          
        it 'renders new template' do 
          post :create, item: item_params.merge({title: ''})
          expect(response).to redirect_to new_item_path
        end
        
        it 'does not respond with flash message' do 
          post :create, item: item_params.merge({title: ''})
          expect(response.status).to eq 302
        end
      end
    end

    describe 'PUT #update' do
      context 'with valid params' do
        before(:each) { put :update, id: item, item: item_params }
          
        it_behaves_like 'redirection to index page'
      end

      context 'with invalid params' do
        context 'with too short title' do
          before(:each) do
            controller.request.stub referer: '/items/' + item.id.to_s + '/edit'
            put :update, id: item, item: item_params.merge({title: 'tea'})
          end
          
          it 'renders edit page' do
            expect(response).to redirect_to edit_item_path
          end
        
          it 'does not respond with HTTP status 302' do
            expect(response.status).to eq 302
          end
        end
      end
    end

    describe 'DELETE #destroy' do
      context 'with valid params' do
        it 'deletes an existing item' do
          expect { delete :destroy, id: item.id }.to change(Item, :count).by(-1)
        end
        
        context 'redirection' do
          before(:each) { delete :destroy, id: item.id }
          
          it_behaves_like 'redirection to index page'
        end
      end
      
      context 'with invalid params' do
        it 'does not delete an item' do
          expect { delete :destroy, id: 0 }.to change(Item, :count).by(0)
        end
        
        context 'redirection' do
          before(:each) { delete :destroy, id: 0 }
          
          it_behaves_like 'redirection to index page'
        end
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
        get :edit, :id => item.id
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
      it 'does not create a new item' do
        expect { post :create, item: item_params }.to change(Item, :count).by(0)
      end
      
      context 'redirection' do
        before(:each) { post :create, item: item_params }
        
        it_behaves_like 'unauthorized_user'
      end
    end

    describe 'GET #edit' do
      before(:each) { get :edit, id: item }
      
      it_behaves_like 'unauthorized_user'
    end

    describe 'PUT #update' do
      before(:each) { put :update, id: item, item: item_params }
      
      it_behaves_like 'unauthorized_user'
    end

    describe 'DELETE #destroy' do
      it 'does not delete an existing item' do
        expect { delete :destroy, id: item }.to change(Item, :count).by(0)
      end
      
      context 'redirection' do
        before(:each) { delete :destroy, id: item }
        
        it_behaves_like 'unauthorized_user'
      end
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