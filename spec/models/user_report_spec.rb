require 'rails_helper'

RSpec.describe UserReport, type: :model do
  context "validation tests" do
    it "ensures blood glucose level is present" do
      user = User.create(name: "John", email: "john@gmail.com", role_id: 1, password: "password", password_confirmation: "password")
      user_report = UserReport.new(user_id: user.id, sample_taken_date: Date.today).save
      
      expect(user_report).to eq(false) 
    end
    
    it "ensures user id is present" do
      user = User.create(name: "John", email: "john@gmail.com", role_id: 1, password: "password", password_confirmation: "password")
      user_report = UserReport.new(blood_glucose_level: 10, sample_taken_date: Date.today).save
      
      expect(user_report).to eq(false) 
    end
    
    it "ensures sample taken date is present" do
      user = User.create(name: "John", email: "john@gmail.com", role_id: 1, password: "password", password_confirmation: "password")
      user_report = UserReport.new(blood_glucose_level: 10, user_id: user.id).save
      
      expect(user_report).to eq(false)
    end
    
    it "should save successfully" do
      user = User.create(name: "John", email: "john@gmail.com", role_id: 1, password: "password", password_confirmation: "password")
      user_report = UserReport.new(blood_glucose_level: 10, user_id: user.id, sample_taken_date: Date.today).save
      
      expect(user_report).to eq(true)
    end
  end
end
