class AddDateToDayEntries < ActiveRecord::Migration[8.0]
  def change
    add_column :day_entries, :date, :date
  end
end
