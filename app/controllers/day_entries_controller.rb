class DayEntriesController < ApplicationController
def index
  matching_day_entries = DayEntry.all

  @list_of_day_entries = matching_day_entries.order({ :created_at => :desc })

  respond_to do |format|
    format.html { render({ :template => "day_entry_templates/index" }) }

    format.json do
      render :json => matching_day_entries.map { |e|
        {
          :id => e.id,
          :title => e.highlight_of_the_day,
          :start => e.date,
          :extendedProps => { :photo => e.photo }
        }
      }
    end
  end
end

  def show
    the_id = params.fetch("path_id")

    matching_day_entries = DayEntry.where({ :id => the_id })

    @the_day_entry = matching_day_entries.at(0)

    render({ :template => "day_entry_templates/show" })
  end

  def create
  the_day_entry = DayEntry.new
  the_day_entry.user_id = params.fetch("query_user_id")
  the_day_entry.date = params.fetch("query_date")
  the_day_entry.highlight_of_the_day = params.fetch("query_highlight_of_the_day")

  if params["query_photo"].present?
    the_day_entry.photo.attach(params["query_photo"])
  end

  if the_day_entry.valid?
    the_day_entry.save
    redirect_to("/day_entries", { :notice => "Day entry created successfully." })
  else
    redirect_to("/day_entries", { :alert => the_day_entry.errors.full_messages.to_sentence })
  end
end

 def update
  the_id = params.fetch("path_id")
  the_day_entry = DayEntry.where({ :id => the_id }).at(0)

  the_day_entry.date = params.fetch("query_date")
  the_day_entry.highlight_of_the_day = params.fetch("query_highlight_of_the_day")

  if params["query_photo"].present?
    the_day_entry.photo.attach(params["query_photo"])
  end

  if the_day_entry.valid?
    the_day_entry.save
    redirect_to("/day_entries/#{the_day_entry.id}", { :notice => "Day entry updated successfully." })
  else
    redirect_to("/day_entries/#{the_day_entry.id}", { :alert => the_day_entry.errors.full_messages.to_sentence })
  end
end

  def destroy
    the_id = params.fetch("path_id")
    the_day_entry = DayEntry.where({ :id => the_id }).at(0)

    the_day_entry.destroy

    redirect_to("/day_entries", { :notice => "Day entry deleted successfully." } )
  end
end
