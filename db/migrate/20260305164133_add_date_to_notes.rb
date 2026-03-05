class AddDateToNotes < ActiveRecord::Migration[8.0]
  def change
    add_column :notes, :date, :date
  end
end
