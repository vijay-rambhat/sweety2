class UserReport < ApplicationRecord
  
  belongs_to :user
  
  validates :blood_glucose_level, presence: true
  validates :sample_taken_date, presence: true
  validates :user_id, presence: true
  
  scope :filter_by_sample_taken_date, ->(sample_taken_date,current_user) { where :sample_taken_date => sample_taken_date, :user_id => current_user.id }
  
  
  def self.get_minimum_maximum_and_average(params,current_user)
    start_date = nil
    if params[:commit] == "Get Report"
      c = []
      if params[:report_type] == "DAILY"
        blood_glucose_levels = UserReport.filter_by_sample_taken_date(params[:end_date],current_user).collect(&:blood_glucose_level)
      elsif params[:report_type] == "MONTH TO DATE"  
        start_date = params[:end_date].to_date.at_beginning_of_month
        blood_glucose_levels = UserReport.where("sample_taken_date>=? and sample_taken_date<=? and user_id=?",start_date,params[:end_date],current_user.id).collect(&:blood_glucose_level)
      else
        start_date = (params[:end_date].to_date - 1.month) 
        blood_glucose_levels = UserReport.where("sample_taken_date>=? and sample_taken_date<=? and user_id=?",start_date,params[:end_date],current_user.id).collect(&:blood_glucose_level) 
      end
      report_type = params[:report_type]
      end_date = params[:end_date]     
    else
      blood_glucose_levels = UserReport.filter_by_sample_taken_date(Date.today,current_user).collect(&:blood_glucose_level)    
      report_type = 'DAILY'
      end_date = Date.today
    end  
    maximum = blood_glucose_levels.max if blood_glucose_levels.present?
    minimum = blood_glucose_levels.min if blood_glucose_levels.present?
    average = (blood_glucose_levels.inject{ |sum, level| sum + level }.to_f / blood_glucose_levels.size).round(2) if blood_glucose_levels.present?
    
    [maximum, minimum, average, report_type, end_date, start_date]
  end# def self.get_minimum_maximum_and_average(params)
  
end
