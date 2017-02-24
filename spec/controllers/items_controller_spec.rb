require 'rails_helper'

RSpec.describe ItemsController, type: :controller do
  let(:item_params) { FactoryGirl.attributes_for(:item) }
  let!(:item) { FactoryGirl.create(:item) }

  # describe 'admin\'s paths' do
  #   before(:each) do
  #     admin = FactoryGirl.create(:admin)
  #     allow(request.env['warden']).to receive(:authenticate!).and_return(admin)
  #     allow(controller).to receive(:current_user).and_return(admin)
  #   end
    
  #   describe 'GET #new' do
  #     it 'renders new page' do
  #       get :new
  #       expect(response).to render_template(:new)
  #     end
  #   end

  #   describe 'POST #create' do
  #     before(:each) do
  #       Item.any_instance.stub(:link_to_weekday).and_return(true)
  #     end
      
  #     context 'with valid params' do
  #       it 'creates a new product' do
  #         expect { post :create, :item => item_params }.to change(Item, :count).by(1)
  #       end

  #       it 'responds with HTTP status 302' do    
  #         post :create, :item => item_params
  #         expect(response.status).to eq 302
  #       end
        
  #       it 'responds with success message' do
  #         post :create, :item => item_params
  #         expect(flash[:success]).to be_present
  #       end
        
  #       it 'redirects to index page' do    
  #         post :create, :item => item_params
  #         expect(response).to redirect_to items_path
  #       end
  #     end

  #     context 'with invalid params' do
  #       it 'does not create a new item' do  
  #         expect { post :create, :item => item_params.merge({title: item.title}) }.to change(Item, :count).by(0)
  #       end

  #       it 'responds with flash message' do 
  #         post :create, :item => item_params.merge({title: item.title})
  #         expect(flash[:alert]).to be_present
  #       end
          
  #       it 'renders new template' do 
  #         post :create, :item => item_params.merge({title: item.title})
  #         expect(response).to render_template(:new)
  #       end
  #     end
  #   end

  #   describe 'GET #index' do
  #     it 'renders index page' do
  #       get :index
  #       expect(response).to render_template(:index)
  #     end
  #   end

  #   describe 'GET #edit' do
  #     context 'with valid params' do
  #       it 'renders an existing item' do
  #         get :edit, :id => item.id
  #         expect(response).to render_template(:edit)
  #       end
  #     end
  #   end

  #   describe 'PUT #update' do
  #     context 'with valid params' do
  #       it 'responds with HTTP status 302' do
  #         allow(@item).to receive(:update_attributes!).and_return(true)
  #         put :update, :id => item, :item => item_params
  #         expect(response.status).to eq 302
  #       end
        
  #       it 'responds with success message' do
  #         allow(@item).to receive(:update_attributes!).and_return(false)
  #         put :update, :id => item, :item => item_params
  #         expect(flash[:success]).to be_present
  #       end

  #       it 'redirects to index page' do
  #         allow(@item).to receive(:update_attributes!).and_return(true)
  #         put :update, :id => item, :item => item_params
  #         expect(response).to redirect_to items_path
  #       end
  #     end

  #     context 'with invalid params' do
  #       context 'with too short title' do
  #         it 'responds with alert message' do
  #           allow(@item).to receive(:update_attributes!).and_return(false)
  #           put :update, :id => item, :item => item_params.merge({title: 'tea'})
  #           expect(flash[:alert]).to be_present
  #         end
          
  #         it 'renders edit page' do
  #           allow(@item).to receive(:update_attributes!).and_return(false)
  #           put :update, :id => item, :item => item_params.merge({title: 'tea'})
  #           expect(response).to render_template(:edit)
  #         end
  #       end
  #     end
  #   end

  #   describe 'DELETE #destroy' do
  #     context 'with valid params' do
  #       it 'deletes an existing item' do
  #         expect { delete :destroy, id: item.id }.to change(Item, :count).by(-1)
  #       end

  #       it 'responds with HTTP status 302' do
  #         allow(@item).to receive(:destroy).and_return(true)
  #         delete :destroy, id: item.id
  #         expect(response.status).to eq 302
  #       end

  #       it 'redirects to index page' do
  #         allow(@item).to receive(:destroy).and_return(true)
  #         delete :destroy, id: item.id
  #         expect(response).to redirect_to items_path
  #       end
  #     end
  #   end
  # end

  # describe 'authenticated user\'s paths' do
  #   before(:each) do
  #     user = FactoryGirl.create(:user)
  #     allow(request.env['warden']).to receive(:authenticate!).and_return(user)
  #     allow(controller).to receive(:current_user).and_return(user)
  #   end
    
  #   describe 'GET #new' do
  #     it 'responds with HTTP status 302' do
  #       get :new
  #       expect(response.status).to eq 302
  #     end

  #     it 'redirects to inform that this page is for admins only' do
  #       get :new
  #       expect(response).to redirect_to not_admins_path
  #     end
  #   end

  #   describe 'GET #index' do
  #     it 'renders index page' do
  #       get :index
  #       expect(response).to render_template(:index)
  #     end
  #   end

  #   describe 'POST #create' do
  #     it 'does not create a new item' do
  #       #  Item.any_instance.stub(:link_to_weekday).and_return(true)
  #       expect { post :create, :item => item_params }.to change(Item, :count).by(0)
  #     end

  #     it 'responds with HTTP status 302' do
  #       post :create, :item => item_params
  #       expect(response.status).to eq 302
  #     end

  #     it 'redirects to inform that this page is for admins only' do
  #       post :create, :item => item_params
  #       expect(response).to redirect_to not_admins_path
  #     end
  #   end

  #   describe 'GET #edit' do
  #     it 'responds with HTTP status 302' do
  #       get :edit, :id => item
  #       expect(response.status).to eq 302
  #     end

  #     it 'redirects to inform that this page is for admins only' do
  #       get :edit, id: item
  #       expect(response).to redirect_to not_admins_path
  #     end
  #   end

  #   describe 'PUT #update' do
  #     it 'responds with HTTP status 302' do
  #       put :update, :id => item, :item => item_params
  #       expect(response.status).to eq 302
  #     end

  #     it 'redirects to inform that this page is for admins only' do
  #       put :update, :id => item, :item => item_params
  #       expect(response).to redirect_to not_admins_path
  #     end
  #   end

  #   describe 'DELETE #destroy' do
  #     it 'does not delete an existing product' do
  #       expect { delete :destroy, :id => item }.to change(Item, :count).by(0)
  #     end

  #     it 'responds with HTTP status 302' do
  #       delete :destroy, :id => item
  #       expect(response.status).to eq 302
  #     end

  #     it 'redirects to inform that this page is for admins only' do
  #       delete :destroy, :id => item
  #       expect(response).to redirect_to not_admins_path
  #     end
  #   end
  # end

  # describe 'random visitor\'s paths' do
  #   before(:each) do
  #     allow(request.env['warden']).to receive(:authenticate!).and_throw(:warden, {:scope => :user})
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
  #     it 'does not create a new item' do
  #       expect { post :create, :item => item_params }.to change(Item, :count).by(0)
  #     end

  #     it 'responds with HTTP status 302' do
  #       post :create, :item => item_params
  #       expect(response.status).to eq 302
  #     end
      
  #     it 'redirects to log in page' do
  #       post :create, :item => item_params
  #       expect(response).to redirect_to new_user_session_path
  #     end
      
  #     it 'flashes that there is a need to sign in or sign up before continuing' do
  #       post :create, :item => item_params
  #       expect(flash[:alert]).to be_present
  #     end
  #   end

  #   describe 'GET #edit' do
  #     it 'responds with HTTP status 302' do
  #       get :edit, :id => item
  #       expect(response.status).to eq 302
  #     end
      
  #     it 'redirects to log in page' do
  #       get :edit, :id => item
  #       expect(response).to redirect_to new_user_session_path
  #     end
      
  #     it 'flashes that there is a need to sign in or sign up before continuing' do
  #       get :edit, :id => item
  #       expect(flash[:alert]).to be_present
  #     end
  #   end

  #   describe 'PUT #update' do
  #     it 'responds with HTTP status 302' do
  #       put :update, :id => item, :item => item_params
  #       expect(response.status).to eq 302
  #     end
      
  #     it 'redirects to log in page' do
  #       put :update, :id => item, :item => item_params
  #       expect(response).to redirect_to new_user_session_path
  #     end
      
  #     it 'flashes that there is a need to sign in or sign up before continuing' do
  #       put :update, :id => item, :item => item_params
  #       expect(flash[:alert]).to be_present
  #     end
  #   end

  #   describe 'DELETE #destroy' do
  #     it 'does not delete an existing item' do
  #       expect { delete :destroy, :id => item }.to change(Item, :count).by(0)
  #     end

  #     it 'responds with HTTP status 302' do
  #       delete :destroy, :id => item
  #       expect(response.status).to eq 302
  #     end
      
  #     it 'redirects to log in page' do
  #       delete :destroy, :id => item
  #       expect(response).to redirect_to new_user_session_path
  #     end
      
  #     it 'flashes that there is a need to sign in or sign up before continuing' do
  #       delete :destroy, :id => item
  #       expect(flash[:alert]).to be_present
  #     end
  #   end
  # end
end