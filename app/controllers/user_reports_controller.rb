class UserReportsController < ApplicationController
  
  def index
    @maximum = nil
    @minimum = nil
    @average = nil
    @user_report = UserReport.new
    
    @maximum, @minimum, @average, @report_type, @end_date, @start_date = UserReport.get_minimum_maximum_and_average(params,current_user)
  end
  
  def create
    @user_report = UserReport.new
    @user_report.blood_glucose_level = params[:user_report][:blood_glucose_level]
    @user_report.user_id = current_user.id
    @user_report.sample_taken_date = Date.today
    @user_report.save
    
    redirect_to user_reports_path
  end
  
  def check_if_user_submitted_max_times
    blood_glucose_sample_size = UserReport.where(:user_id => current_user.id, :sample_taken_date => Date.today).collect(&:blood_glucose_level).size
    allow_submit = true
    if blood_glucose_sample_size == 4
      allow_submit = false
    else
      allow_submit = true  
    end
    
    respond_to do |format|
      format.json{render json: allow_submit}
    end
  end
  
end
