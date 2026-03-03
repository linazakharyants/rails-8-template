class HabitChecksController < ApplicationController
  def index
    matching_habit_checks = HabitCheck.all

    @list_of_habit_checks = matching_habit_checks.order({ :created_at => :desc })

    render({ :template => "habit_check_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_habit_checks = HabitCheck.where({ :id => the_id })

    @the_habit_check = matching_habit_checks.at(0)

    render({ :template => "habit_check_templates/show" })
  end

  def create
    the_habit_check = HabitCheck.new
    the_habit_check.user_id = params.fetch("query_user_id")
    the_habit_check.habit_id = params.fetch("query_habit_id")
    the_habit_check.completed = params.fetch("query_completed")
    the_habit_check.day_entry_id = params.fetch("query_day_entry_id")

    if the_habit_check.valid?
      the_habit_check.save
      redirect_to("/habit_checks", { :notice => "Habit check created successfully." })
    else
      redirect_to("/habit_checks", { :alert => the_habit_check.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_habit_check = HabitCheck.where({ :id => the_id }).at(0)

    the_habit_check.user_id = params.fetch("query_user_id")
    the_habit_check.habit_id = params.fetch("query_habit_id")
    the_habit_check.completed = params.fetch("query_completed")
    the_habit_check.day_entry_id = params.fetch("query_day_entry_id")

    if the_habit_check.valid?
      the_habit_check.save
      redirect_to("/habit_checks/#{the_habit_check.id}", { :notice => "Habit check updated successfully." } )
    else
      redirect_to("/habit_checks/#{the_habit_check.id}", { :alert => the_habit_check.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_habit_check = HabitCheck.where({ :id => the_id }).at(0)

    the_habit_check.destroy

    redirect_to("/habit_checks", { :notice => "Habit check deleted successfully." } )
  end
end
