class CreateUserReports < ActiveRecord::Migration[5.2]
  def change
    create_table :user_reports do |t|
      t.integer :blood_glucose_level
      t.integer :user_id
      t.date :sample_taken_date
      t.timestamps
    end
  end
end
