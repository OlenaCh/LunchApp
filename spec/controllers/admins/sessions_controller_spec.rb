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
        post :create, admin: { email: admin.email, password: admin.password }
        expect(subject.current_admin).to eq admin
      end
      
      it 'redirects to menu index page' do
        sign_in admin
        post :create, admin: { email: admin.email, password: admin.password }
        expect(response.status).to eq 302
      end
    end

    context 'with invalid attributes' do
      shared_examples 'wrong credentials' do
        it 'redirects to unauthorized path' do
          expect(JSON.parse(response.body)['status']).to eq 400
        end
      end
      
      context 'it does not login without email' do
        before(:each) { post :create, admin: { email: '', password: admin.password } }
        
        it_behaves_like 'wrong credentials'
      end

      context 'it does not login without password' do
        before(:each) { post :create, admin: { email: admin.email, password: '' } }
        
        it_behaves_like 'wrong credentials'
      end
      
      context 'it does not login with wrong password' do
        before(:each) { post :create, admin: { email: admin.email, password: 'eeeee' } }
        
        it_behaves_like 'wrong credentials'
      end
      
      context 'admin is not signed in' do
        before(:each) { post :create, admin: { email: '', password: '' } }
        
        it_behaves_like 'wrong credentials'
      end
    end
  end
end