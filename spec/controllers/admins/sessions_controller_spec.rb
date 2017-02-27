require 'rails_helper'

RSpec.describe Admins::SessionsController, type: :controller do
  let!(:admin) { FactoryGirl.create(:admin) }
  
  before(:each) do
    @request.env['devise.mapping'] = Devise.mappings[:admin]
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'logs in admin' do
        sign_in admin
        post :create, { :email => admin.email, :password => admin.password }
        expect(subject.current_admin).to eq admin
      end
      
      it 'redirects to menu index page' do
        sign_in admin
        post :create, { :email => admin.email, :password => admin.password }
        expect(response).to redirect_to menus_path  
      end
    end

    context 'with invalid attributes' do
      context 'it does not login without email' do
        it 'does not assign current admin' do
          post :create, { :email => '', :password => admin.password }
          expect(subject.current_admin).to eq(nil)
        end
      end

      context 'it does not login without password' do
        it 'does not assign current admin' do
          post :create, { :email => admin.email, :password => '' }
          expect(subject.current_admin).to eq(nil)
        end
      end
      
      context 'it does not login with wrong password' do
        it 'does not assign current admin' do
          post :create, { :email => admin.email, :password => 'aaaaraaaa' }
          expect(subject.current_admin).to eq(nil)
        end
      end
      
      context 'admin is not signed in' do
        it 'does not assign current admin' do
          post :create, { :email => '', :password => '' }
          expect(subject.current_admin).to eq(nil)
        end
      end
    end
  end
end