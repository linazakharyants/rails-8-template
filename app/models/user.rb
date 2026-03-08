# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  avatar_url             :string
#  bio                    :string
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  name                   :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
       has_many  :dayentries, class_name: "DayEntry", foreign_key: "user_id", dependent: :destroy
       has_many  :habits, class_name: "Habit", foreign_key: "user_id", dependent: :destroy
       has_many  :habitchecks, class_name: "HabitCheck", foreign_key: "user_id", dependent: :destroy
       has_many  :notes, class_name: "Note", foreign_key: "user_id", dependent: :destroy
       has_many  :gratitude_chatbots, class_name: "GratitudeEntry", foreign_key: "user_id", dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  #devise :database_authenticatable, :registerable,
         #:recoverable, :rememberable, :validatable
   has_one_attached :avatar
end
