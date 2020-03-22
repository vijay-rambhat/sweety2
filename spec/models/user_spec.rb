require 'rails_helper'

RSpec.describe User, type: :model do
  context "validation tests" do
    it 'ensures email is present' do
      user = User.new(name: "John").save
      expect(user).to eq(false)
    end
    
    it 'ensures name is present' do
      user = User.new(email: "john@gmail.com").save
      expect(user).to eq(false)
    end
    
    it 'should save successfully' do
      user = User.new(name: "John", email: "john@gmail.com", role_id: 1, password: "password", password_confirmation: "password").save
      expect(user).to eq(true)
    end
  end
  
end
