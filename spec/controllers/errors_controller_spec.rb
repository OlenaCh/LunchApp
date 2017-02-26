require 'rails_helper'

RSpec.describe ErrorsController, type: :controller do
  describe 'GET #no_route' do
    it 'renders no_route template' do 
      get :no_route
      expect(response).to render_template(:no_route)
    end
  end
  
  describe 'GET #record_not_found' do
    it 'renders record_not_found template' do 
      get :record_not_found
      expect(response).to render_template(:record_not_found)
    end
  end
  
  describe 'GET #unauthorized' do
    it 'renders unauthorized template' do 
      get :unauthorized
      expect(response).to render_template(:unauthorized)
    end
  end
end