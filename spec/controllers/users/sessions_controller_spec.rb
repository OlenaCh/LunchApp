require 'rails_helper'

RSpec.describe Users::SessionsController, type: :controller do
  let!(:user) {
    user = FactoryGirl.create(:user)
  }
  
  let!(:sign_in_error) { 
    sign_in_error = "Invalid Email or password." 
  } 

  before(:each) do
    @request.env['devise.mapping'] = Devise.mappings[:user]
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'logs in user' do
        post :create, { :email => user.email, :password => user.password }
        sign_in user
        expect(subject.current_user).to eq user
      end
      
      it 'responds with status 200' do         
        post :create, { :email => user.email, :password => user.password }
        expect(response.status).to eq(200)       
      end
    end

    context 'with invalid attributes' do
      context 'it does not login without email' do
        it 'does not assign current user' do
          post :create, { :email => '', :password => user.password }
          expect(subject.current_user).to eq(nil)
        end
  
        it 'renders errors flash' do
          post :create, { :email => '', :password => user.password }
          expect(flash[:alert]).to eq sign_in_error
        end
      end

      context 'it does not login without password' do
        it 'does not assign current user' do
          post :create, { :email => user.email, :password => '' }
          expect(subject.current_user).to eq(nil)
        end
  
        it 'renders errors flash' do
          post :create, { :email => user.email, :password => '' }
          expect(flash[:alert]).to eq sign_in_error
        end
      end
      
      context 'it does not login with wrong password' do
        it 'does not assign current user' do
          post :create, { :email => user.email, :password => 'aaaaraaaa' }
          expect(subject.current_user).to eq(nil)
        end
  
        it 'renders errors flash' do
          post :create, { :email => user.email, :password => 'aaaaraaaa' }
          expect(flash[:alert]).to eq sign_in_error
        end
      end
      
      context 'user is not signed in' do
        it 'does not assign current user' do
          post :create, { :email => '', :password => '' }
          expect(subject.current_user).to eq(nil)
        end
        
        it 'renders error messages' do           
          post :create, { :email => '', :password => '' }           
          expect(flash[:alert]).to eq sign_in_error        
        end
      end
    end
  end

  describe 'DELETE #destory' do
    before(:each) do
      post :create, { email: user.email, password: user.password }
      @header = { "access-token" => response.header["access-token"],
                  "client" => response.header["client"],
                  "uid" => response.header["uid"] }
    end

    context 'with existing user' do
      it 'logs out user' do
        delete :destroy, {}, @header
        expect(response.status).to eq(302)
      end
    end
  end
end