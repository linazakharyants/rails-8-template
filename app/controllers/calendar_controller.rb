class CalendarController < ApplicationController
  before_action :authenticate_user!

  def index
    respond_to do |format|
      format.html do
        render({ :template => "calendar_templates/index" })
      end

      format.json do
        start_param = params["start"]
        end_param   = params["end"]

        scoped = current_user.dayentries.where.not({ :date => nil })

        if start_param.present? && end_param.present?
          start_date = Date.parse(start_param)
          end_date   = Date.parse(end_param)
          scoped = scoped.where({ :date => start_date...end_date })
        end

        user_id = current_user.id
        habit_ids = current_user.habits.pluck(:id)
        habits_count = habit_ids.length

        completed_by_day_entry = HabitCheck.where({
          :user_id => user_id,
          :completed => true,
          :habit_id => habit_ids
        }).group(:day_entry_id).count

        render :json => scoped.map { |e|
          completed = completed_by_day_entry[e.id].to_i
          percent = (habits_count > 0) ? ((completed.to_f / habits_count) * 100).round : nil

          {
            :id => e.id,
            :title => (e.highlight_of_the_day.presence || ""),
            :start => e.date,
            :allDay => true,
            :extendedProps => {
              :photo => (e.photo.attached? ? url_for(e.photo) : nil),
              :habit_percent => percent
            }
          }
        }
      end
    end
  end
end
