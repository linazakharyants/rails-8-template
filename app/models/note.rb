# == Schema Information
#
# Table name: notes
#
#  id           :bigint           not null, primary key
#  body         :string
#  date         :date
#  title        :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  day_entry_id :integer
#  user_id      :integer
#
class Note < ApplicationRecord
  belongs_to :user, required: true, class_name: "User", foreign_key: "user_id"
  belongs_to :day_entry, required: true, class_name: "DayEntry", foreign_key: "day_entry_id"

  has_rich_text :content
end
