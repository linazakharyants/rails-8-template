class CalendarController < ApplicationController
  
  def index
    respond_to do |format|
      format.html do
        render({ :template => "calendar_templates/index" })
      end

      format.json do
        start_param = params["start"]
        end_param   = params["end"]

        scoped = DayEntry.where.not({ :date => nil })

        if start_param.present? && end_param.present?
          start_date = Date.parse(start_param)
          end_date   = Date.parse(end_param)
          scoped = scoped.where({ :date => start_date...end_date })
        end

        render :json => scoped.map { |e|
          {
            :id => e.id,
            :title => (e.highlight_of_the_day.presence || "Day entry"),
            :start => e.date,
            :allDay => true,
            :extendedProps => {
              :photo => (e.photo.attached? ? url_for(e.photo) : nil)
            }
          }
        }
      end
    end
  end
end
