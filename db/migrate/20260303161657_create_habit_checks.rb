class CreateHabitChecks < ActiveRecord::Migration[8.0]
  def change
    create_table :habit_checks do |t|
      t.integer :user_id
      t.integer :habit_id
      t.boolean :completed
      t.integer :day_entry_id

      t.timestamps
    end
  end
end
