# == Schema Information
#
# Table name: habit_checks
#
#  id           :bigint           not null, primary key
#  completed    :boolean
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  day_entry_id :integer
#  habit_id     :integer
#  user_id      :integer
#
class HabitCheck < ApplicationRecord
end
