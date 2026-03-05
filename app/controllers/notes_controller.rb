class NotesController < ApplicationController
  def index
    @list_of_notes = Note.all.order({ :date => :desc, :created_at => :desc })

    # Optional: if you ever do /notes?date=2026-03-11
    if params["date"].present?
      @selected_date = Date.parse(params["date"])
      @list_of_notes = @list_of_notes.where({ :date => @selected_date })
    end

    render({ :template => "note_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")
    @the_note = Note.where({ :id => the_id }).at(0)

    render({ :template => "note_templates/show" })
  end

  def create
    the_note = Note.new

    # TEMP until login exists
    the_note.user_id = 1

    # Auto date: use param if passed, otherwise today
    if params["query_date"].present?
      the_note.date = Date.parse(params["query_date"])
    else
      the_note.date = Date.current
    end

    the_note.body = params.fetch("query_body")

    if the_note.valid?
      the_note.save
      redirect_to("/notes/#{the_note.id}", { :notice => "Note saved." })
    else
      redirect_to("/notes", { :alert => the_note.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_note = Note.where({ :id => the_id }).at(0)

    the_note.body = params.fetch("query_body")

    # keep date as-is (or allow updating if you want)
    if the_note.valid?
      the_note.save
      redirect_to("/notes/#{the_note.id}", { :notice => "Note updated." })
    else
      redirect_to("/notes/#{the_note.id}", { :alert => the_note.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_note = Note.where({ :id => the_id }).at(0)

    the_note.destroy
    redirect_to("/notes", { :notice => "Note deleted." })
  end
end

  def update
    the_id = params.fetch("path_id")
    the_note = Note.where({ :id => the_id }).at(0)

    the_note.user_id = params.fetch("query_user_id")
    the_note.title = params.fetch("query_title")
    the_note.body = params.fetch("query_body")
    the_note.day_entry_id = params.fetch("query_day_entry_id")

    if the_note.valid?
      the_note.save
      redirect_to("/notes/#{the_note.id}", { :notice => "Note updated successfully." } )
    else
      redirect_to("/notes/#{the_note.id}", { :alert => the_note.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_note = Note.where({ :id => the_id }).at(0)

    the_note.destroy

    redirect_to("/notes", { :notice => "Note deleted successfully." } )
  end
