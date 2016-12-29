require 'rails_helper'

RSpec.describe OrganizationsController, type: :controller do
  let!(:organization_params) {
    organization_params = FactoryGirl.attributes_for(:organization)
  }

  let!(:organization) {
    organization = FactoryGirl.create(:organization)
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

      it 'redirects to inform that this page is for users only' do
        get :new
        expect(response).to redirect_to not_users_path
      end   
    end

    describe 'POST #create' do
      it 'does not create a new organization' do
        expect { post :create, :organization => organization_params }.to change(Organization, :count).by(0)
      end

      it 'responds with HTTP status 302' do
        post :create, :organization => organization_params
        expect(response.status).to eq 302
      end

      it 'redirects to inform that this page is for users only' do
        post :create, :organization => organization_params
        expect(response).to redirect_to not_users_path
      end
    end
  end

  describe 'authenticated user\'s paths' do
    before(:each) do
      user = FactoryGirl.create(:user)
      allow(request.env['warden']).to receive(:authenticate!).and_return(user)
      allow(controller).to receive(:current_user).and_return(user)
    end

    describe 'GET #new' do
      it 'gets a page for a new organization' do
        get :new
        expect(response.status).to eq 200
      end   
    end
    
    describe 'POST #create' do
      context 'with valid params' do
        it 'creates a new organization' do
          expect { post :create, :organization => organization_params }.to change(Organization, :count).by(1)
        end
    
        it 'responds with HTTP status 302' do
          post :create, :organization => organization_params
          expect(response.status).to eq 302
        end

        it 'redirects to the edit registration form page only' do
          post :create, :organization => organization_params
          expect(response).to redirect_to edit_user_registration_path
        end  
      end
      
      context 'with invalid params' do
        it 'does not create a new organization' do
          expect { post :create, :organization => organization_params.merge({title: organization.title}) }.to change(Organization, :count).by(0)
        end
    
        # it 'responds with HTTP status 302' do
        #   post :create, :organization => organization_params.merge({title: organization.title}
        #   expect(response.status).to eq 302
        # end

        # it 'redirects to inform that this page is for admins only' do
        #   post :create, :organization => organization_params
        #   expect(response).to redirect_to edit_user_registration_path
        # end  
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

    describe 'POST #create' do
      it 'does not create a new organization' do
        expect { post :create, :organization => organization_params }.to change(Item, :count).by(0)
      end

      it 'responds with HTTP status 302' do
        post :create, :organization => organization_params
        expect(response.status).to eq 302
      end
      
      it 'redirects to log in page' do
        post :create, :organization => organization_params
        expect(response).to redirect_to new_user_session_path
      end
      
      it 'flashes that there is a need to sign in or sign up before continuing' do
        post :create, :organization => organization_params
        expect(flash[:alert]).to be_present
      end
    end
  end
end