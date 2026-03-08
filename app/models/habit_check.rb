# == Schema Information
#
# Table name: habit_checks
#
#  id           :bigint           not null, primary key
#  completed    :boolean
#  date         :date
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  day_entry_id :integer
#  habit_id     :integer
#  user_id      :integer
#
class HabitCheck < ApplicationRecord
  belongs_to :user, required: true, class_name: "User", foreign_key: "user_id"
  belongs_to :day_entry, required: true, class_name: "DayEntry", foreign_key: "day_entry_id"
  belongs_to :habit, required: true, class_name: "Habit", foreign_key: "habit_id"
end
