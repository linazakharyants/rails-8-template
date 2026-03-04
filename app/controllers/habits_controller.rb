class HabitsController < ApplicationController
  def index
    matching_habits = Habit.all

    @list_of_habits = matching_habits.order({ :created_at => :desc })

    render({ :template => "habit_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_habits = Habit.where({ :id => the_id })

    @the_habit = matching_habits.at(0)

    render({ :template => "habit_templates/show" })
  end

  def create
  the_habit = Habit.new

  # TEMP until login exists:
  the_habit.user_id = 1

  the_habit.name = params.fetch("query_name")
  the_habit.description = params.fetch("query_description")

  if the_habit.valid?
    the_habit.save
    redirect_to("/habits", { :notice => "Habit created successfully." })
  else
    redirect_to("/habits", { :alert => the_habit.errors.full_messages.to_sentence })
  end
end

  def update
  the_id = params.fetch("path_id")
  the_habit = Habit.where({ :id => the_id }).at(0)

  the_habit.name = params.fetch("query_name")
  the_habit.description = params.fetch("query_description")

  if the_habit.valid?
    the_habit.save
    redirect_to("/habits/#{the_habit.id}", { :notice => "Habit updated successfully." })
  else
    redirect_to("/habits/#{the_habit.id}", { :alert => the_habit.errors.full_messages.to_sentence })
  end
end

  def destroy
    the_id = params.fetch("path_id")
    the_habit = Habit.where({ :id => the_id }).at(0)

    the_habit.destroy

    redirect_to("/habits", { :notice => "Habit deleted successfully." } )
  end
end
