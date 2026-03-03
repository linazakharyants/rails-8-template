# == Schema Information
#
# Table name: notes
#
#  id           :bigint           not null, primary key
#  body         :string
#  title        :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  day_entry_id :integer
#  user_id      :integer
#
class Note < ApplicationRecord
end
