class CreateDayEntries < ActiveRecord::Migration[8.0]
  def change
    create_table :day_entries do |t|
      t.integer :user_id
      t.string :highlight_of_the_day
      t.string :photo

      t.timestamps
    end
  end
end
