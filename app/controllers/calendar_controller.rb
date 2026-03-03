class CalendarController < ApplicationController

def index
  # Determine which month to show
  @month = params[:month].present? ? Date.parse(params[:month]) : Date.current
  @month = @month.beginning_of_month

  # Build grid range (Sunday → Saturday layout)
  grid_start = @month.beginning_of_week(:sunday)
  grid_end   = @month.end_of_month.end_of_week(:sunday)

  @dates = (grid_start..grid_end).to_a
   render({ :template => "calendar_templates/index" })
end

end
