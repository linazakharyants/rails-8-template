class AddDateToHabitChecks < ActiveRecord::Migration[8.0]
  def change
  add_index :habit_checks, [:user_id, :habit_id, :date], unique: true
end
end
