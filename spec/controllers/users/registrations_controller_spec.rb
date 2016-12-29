require 'rails_helper'

RSpec.describe Users::RegistrationsController, type: :controller do
  let!(:user_params) {
    user_params = FactoryGirl.attributes_for(:user)
  }

  let!(:user) {
    user = FactoryGirl.create(:user)
  }

  before(:each) do
    @request.env['devise.mapping'] = Devise.mappings[:user]
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new user' do
        expect { post :create, :user => user_params }.to change(User, :count).by(1)
      end

      it 'responds with HTTP status 302' do
        post :create, :user => user_params
        expect(response.status).to eq 302
      end
      
      it 'redirects to items path' do
        post :create, :user => user_params
        expect(response).to redirect_to items_path
      end
    end

    context 'with invalid params' do
      context 'with duplicated email' do
        it 'does not create a new user' do
          expect { post :create, :user => user_params.merge({email: user.email}) }.to change(User, :count).by(0)
        end
        
        it 'renders template for a new registration path' do
          post :create, :user => user_params.merge({email: user.email}) 
          expect(response).to render_template(:new)
        end
      end
      
      context 'with missing email' do
        it 'does not create a new user' do
          expect { post :create, :user => user_params.merge({email: ''}) }.to change(User, :count).by(0)
        end
        
        it 'renders template for a new registration path' do
          post :create, :user => user_params.merge({email: ''}) 
          expect(response).to render_template(:new)
        end
      end
      
      context 'with missing password' do
        it 'does not create a new user' do
          expect { post :create, :user => user_params.merge({password: ''}) }.to change(User, :count).by(0)
        end
        
        it 'renders template for a new registration path' do
          post :create, :user => user_params.merge({password: ''}) 
          expect(response).to render_template(:new)
        end
      end
      
      context 'with missing name' do
        it 'does not create a new user' do
          expect { post :create, :user => user_params.merge({name: ''}) }.to change(User, :count).by(0)
        end
        
        it 'renders template for a new registration path' do
          post :create, :user => user_params.merge({name: ''}) 
          expect(response).to render_template(:new)
        end
      end
    end
  end
  
  describe 'PUT #update' do
    before(:each) do
      allow(request.env['warden']).to receive(:authenticate!).and_return(user)
      allow(controller).to receive(:current_user).and_return(user)
    end
    
    context 'it updates information about user' do
      context 'it updates email' do
        it 'updates the email of created user' do
          put :update, :id => user, :user => { :email => 'test@gmail.com', 
                                              :current_password => user.password }
          user.update(email: 'test@gmail.com')
          expect(subject.current_user.email).to eq 'test@gmail.com'
        end
        
        it 'redirects to items path' do
          put :update, :id => user, :user => { :email => 'test@gmail.com', 
                                              :current_password => user.password }
          expect(response).to redirect_to root_path
        end
      end
      
      context 'it updates password' do
        it 'updates the password of created user' do
          put :update, :id => user, :user => { :password => '33333333', :password_confirmation => '33333333', 
                                              :current_password => user.password }
          user.update(password: '33333333')
          expect(subject.current_user.password).to eq '33333333'
        end
        
        it 'redirects to items path' do
          put :update, :id => user, :user => { :password => '33333333', :password_confirmation => '33333333', 
                                              :current_password => user.password }
          expect(response).to redirect_to root_path
        end
      end
      
      context 'it updates name' do
        it 'updates the name of created user' do
          put :update, :id => user, :user => { :name => 'Tester', 
                                              :current_password => user.password }
          user.update(name: 'Tester')
          expect(subject.current_user.name).to eq 'Tester'
        end
        
        it 'redirects to items path' do
          put :update, :id => user, :user => { :name => 'Tester', 
                                              :current_password => user.password }
          expect(response).to redirect_to root_path
        end
      end
      
      context 'it updates organization to which belongs created user' do
        it 'updates the organization to which belongs created user' do
          put :update, :id => user, :user => { :organization_id => 2, 
                                              :current_password => user.password }
          user.update(organization_id: 2)
          expect(subject.current_user.organization_id).to eq 2
        end
        
        it 'redirects to items path' do
          put :update, :id => user, :user => { :organization_id => 2, 
                                              :current_password => user.password }
          expect(response).to redirect_to root_path
        end
      end
    end
  end
end