require 'rails_helper'

RSpec.describe UserReportsController, type: :controller do
  context 'GET #index' do
    before :each do
      user = User.create(name: "John", email: "john@gmail.com", role_id: 1, password: "password", password_confirmation: "password")
      sign_in(user, scope: :user)
    end
    it 'returns a success response' do  
      get :index
      expect(response).to be_successful
    end
  end
  
  context 'GET #check_if_user_submitted_max_times' do
    before :each do
      user = User.create(name: "John", email: "john@gmail.com", role_id: 1, password: "password", password_confirmation: "password")
      sign_in(user, scope: :user)
    end
    it 'Less than 4 samples taken for the day' do  
      get :check_if_user_submitted_max_times,format: :json
      parsed_response = JSON.parse(response.body)
      expect(parsed_response).to eq(true)
    end
  end
end
