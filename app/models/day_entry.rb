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
end
