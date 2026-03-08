class NotesController < ApplicationController
  before_action :authenticate_user!

  def index
    @list_of_notes = current_user.notes.order({ :date => :desc, :created_at => :desc })

    if params["date"].present?
      @selected_date = Date.parse(params["date"])
      @list_of_notes = @list_of_notes.where({ :date => @selected_date })
    end

    render({ :template => "note_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")
    @the_note = current_user.notes.where({ :id => the_id }).at(0)

    render({ :template => "note_templates/show" })
  end

  def create
    the_note = Note.new

    the_note.user_id = current_user.id

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
    the_note = current_user.notes.where({ :id => the_id }).at(0)

    the_note.body = params.fetch("query_body")

    if the_note.valid?
      the_note.save
      redirect_to("/notes/#{the_note.id}", { :notice => "Note updated." })
    else
      redirect_to("/notes/#{the_note.id}", { :alert => the_note.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_note = current_user.notes.where({ :id => the_id }).at(0)

    the_note.destroy

    redirect_to("/notes", { :notice => "Note deleted." })
  end
end
