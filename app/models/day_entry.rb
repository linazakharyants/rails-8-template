# == Schema Information
#
# Table name: day_entries
#
#  id                   :bigint           not null, primary key
#  date                 :date
#  highlight_of_the_day :string
#  photo                :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  user_id              :integer
#
class DayEntry < ApplicationRecord
  belongs_to :user, required: true, class_name: "User", foreign_key: "user_id"
  has_many  :notes, class_name: "Note", foreign_key: "day_entry_id", dependent: :destroy
  has_many  :habit_checks, class_name: "HabitCheck", foreign_key: "day_entry_id", dependent: :destroy
  has_one_attached :photo
end
