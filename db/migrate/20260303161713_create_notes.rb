class CreateNotes < ActiveRecord::Migration[8.0]
  def change
    create_table :notes do |t|
      t.integer :user_id
      t.string :title
      t.string :body
      t.integer :day_entry_id

      t.timestamps
    end
  end
end
