class DayEntriesController < ApplicationController

  def index
    matching_day_entries = DayEntry.all
    @list_of_day_entries = matching_day_entries.order({ :created_at => :desc })

    respond_to do |format|
      format.html { render({ :template => "day_entry_templates/index" }) }

     
      format.json do
        render :json => matching_day_entries.where.not({ :date => nil }).map { |e|
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

  # SHOW
  def show
    the_id = params.fetch("path_id")
    @the_day_entry = DayEntry.where({ :id => the_id }).at(0)
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
    redirect_to("/day_entries", { :notice => "Day entry deleted successfully." })
  end


  def edit_highlight
    date = safe_parse_date(params.fetch("date"))
    @the_day_entry = find_or_initialize_by_date(date)

 

    render({ :template => "day_entry_templates/edit_highlight" })
  end


  def upsert_highlight
    date = safe_parse_date(params.fetch("date"))
    the_day_entry = DayEntry.where({ :date => date }).at(0) || DayEntry.new

    the_day_entry.date = date
    the_day_entry.highlight_of_the_day = params["query_highlight_of_the_day"]

    if params["query_user_id"].present?
      the_day_entry.user_id = params["query_user_id"]
    end

    if the_day_entry.valid?
      the_day_entry.save
      redirect_to("/day_entries/#{the_day_entry.id}", { :notice => "Highlight saved successfully." })
    else
      redirect_to("/day_entries/highlight/#{date}", { :alert => the_day_entry.errors.full_messages.to_sentence })
    end
  end


  def edit_frame
    the_id = params.fetch("path_id")
    @the_day_entry = DayEntry.where({ :id => the_id }).at(0)
    render({ :template => "day_entry_templates/edit_frame" })
  end

  def update_frame
    the_id = params.fetch("path_id")
    the_day_entry = DayEntry.where({ :id => the_id }).at(0)

    if params["query_photo"].present?
      the_day_entry.photo.attach(params["query_photo"])
    end

    if the_day_entry.valid?
      the_day_entry.save
      redirect_to("/day_entries/#{the_day_entry.id}", { :notice => "Frame updated successfully." })
    else
      redirect_to("/day_entries/frame/#{the_day_entry.id}", { :alert => the_day_entry.errors.full_messages.to_sentence })
    end
  end

  private

  def safe_parse_date(raw)
    Date.parse(raw.to_s)
  rescue ArgumentError
  
    Date.current
  end

  def find_or_initialize_by_date(date)
    DayEntry.where({ :date => date }).at(0) || DayEntry.new({ :date => date })
  end
end
