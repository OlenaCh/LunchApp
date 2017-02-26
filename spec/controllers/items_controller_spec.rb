require 'rails_helper'

RSpec.describe ItemsController, type: :controller do
  let(:item_params) { FactoryGirl.attributes_for(:item) }
  let!(:item) { FactoryGirl.create(:item) }

  describe 'admin\'s paths' do
    before(:each) do
      admin = FactoryGirl.create(:admin)
      allow(request.env['warden']).to receive(:authenticate!).and_return(admin)
      allow(controller).to receive(:current_admin).and_return(admin)
    end
    
    describe 'GET #new' do
      it 'renders new page' do
        get :new
        expect(response).to render_template(:new)
      end
    end

    describe 'POST #create' do
      context 'with valid params' do
        it 'creates a new product' do
          expect { post :create, :item => item_params }.to change(Item, :count).by(1)
        end
        
        it 'redirects to index page' do    
          post :create, :item => item_params
          expect(response).to redirect_to items_path
        end
        
        it 'responds with HTTP status 302' do    
          post :create, :item => item_params
          expect(response.status).to eq 302
        end
      end

      context 'with invalid params' do
        # it 'does not create a new item' do  
        #   expect { post :create, :item => item_params.merge({title: item.title}) }.to change(Item, :count).by(0)
        # end

        # it 'does not respond with flash message' do 
        #   post :create, :item => item_params.merge({title: item.title})
        #   expect(response.status).not_to eq 302
        # end
          
        # it 'renders new template' do 
        #   post :create, :item => item_params.merge({title: item.title})
        #   expect(response).to render_template(:new)
        # end
      end
    end

    describe 'GET #index' do
      it 'renders index page' do
        get :index
        expect(response).to render_template(:index)
      end
    end

    describe 'GET #edit' do
      context 'with valid params' do
        it 'renders an existing item' do
          get :edit, :id => item.id
          expect(response).to render_template(:edit)
        end
      end
      
      context 'with invalid params' do
        it 'does not render an existing item' do
          # get :edit, :id => item.id
          # expect(response).to render_template(:edit)
        end
      end
    end

    describe 'PUT #update' do
      context 'with valid params' do
        it 'responds with HTTP status 302' do
          put :update, :id => item, :item => item_params
          expect(response.status).to eq 302
        end

        it 'redirects to index page' do
          put :update, :id => item, :item => item_params
          expect(response).to redirect_to items_path
        end
      end

      context 'with invalid params' do
        context 'with too short title' do
          it 'does not respond with HTTP status 302' do
            put :update, :id => item, :item => item_params.merge({title: 'tea'})
            expect(response.status).not_to eq 302
          end
          
          it 'renders edit page' do
            put :update, :id => item, :item => item_params.merge({title: 'tea'})
            expect(response).to render_template(:edit)
          end
        end
      end
    end

    describe 'DELETE #destroy' do
      context 'with valid params' do
        it 'deletes an existing item' do
          expect { delete :destroy, id: item.id }.to change(Item, :count).by(-1)
        end

        it 'responds with HTTP status 302' do
          delete :destroy, id: item.id
          expect(response.status).to eq 302
        end

        it 'redirects to index page' do
          delete :destroy, id: item.id
          expect(response).to redirect_to items_path
        end
      end
      
      context 'with invalid params' do
        # it 'does not delete an item' do
        #   expect { delete :destroy, id: -(item.id) }.to change(Item, :count).by(0)
        # end

        # it 'responds with HTTP status 302' do
        #   delete :destroy, id: item.id
        #   expect(response.status).to eq 302
        # end

        # it 'redirects to index page' do
        #   delete :destroy, id: item.id
        #   expect(response).to redirect_to items_path
        # end
      end
    end
  end

  describe 'random visitor\'s paths' do
    before(:each) do
      allow(request.env['warden']).to receive(:authenticate!).and_throw(:warden, {:scope => :user})
    end

    describe 'GET #index' do
      it 'renders index page' do
        get :index
        expect(response).to render_template(:index)
      end
    end

    describe 'POST #create' do
      # it 'does not create a new item' do
      #   expect { post :create, :item => item_params }.to change(Item, :count).by(0)
      # end

      # it 'responds with HTTP status 302' do
      #   post :create, :item => item_params
      #   expect(response.status).to eq 302
      # end
      
      # it 'redirects to log in page' do
      #   post :create, :item => item_params
      #   expect(response).to redirect_to new_user_session_path
      # end
      
      # it 'flashes that there is a need to sign in or sign up before continuing' do
      #   post :create, :item => item_params
      #   expect(flash[:alert]).to be_present
      # end
    end

    describe 'GET #edit' do
      # it 'responds with HTTP status 302' do
      #   get :edit, :id => item
      #   expect(response.status).to eq 302
      # end
      
      # it 'redirects to log in page' do
      #   get :edit, :id => item
      #   expect(response).to redirect_to new_user_session_path
      # end
      
      # it 'flashes that there is a need to sign in or sign up before continuing' do
      #   get :edit, :id => item
      #   expect(flash[:alert]).to be_present
      # end
    end

    describe 'PUT #update' do
      # it 'responds with HTTP status 302' do
      #   put :update, :id => item, :item => item_params
      #   expect(response.status).to eq 302
      # end
      
      # it 'redirects to log in page' do
      #   put :update, :id => item, :item => item_params
      #   expect(response).to redirect_to new_user_session_path
      # end
      
      # it 'flashes that there is a need to sign in or sign up before continuing' do
      #   put :update, :id => item, :item => item_params
      #   expect(flash[:alert]).to be_present
      # end
    end

    describe 'DELETE #destroy' do
      # it 'does not delete an existing item' do
      #   expect { delete :destroy, :id => item }.to change(Item, :count).by(0)
      # end

      # it 'responds with HTTP status 302' do
      #   delete :destroy, :id => item
      #   expect(response.status).to eq 302
      # end
    end
  end
end