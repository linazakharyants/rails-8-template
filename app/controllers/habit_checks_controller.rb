class HabitChecksController < ApplicationController
  before_action :authenticate_user!

  def index
    matching_habit_checks = current_user.habitchecks
    @list_of_habit_checks = matching_habit_checks.order({ :created_at => :desc })

    render({ :template => "habit_check_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")
    matching_habit_checks = current_user.habitchecks.where({ :id => the_id })
    @the_habit_check = matching_habit_checks.at(0)

    render({ :template => "habit_check_templates/show" })
  end

  def toggle
    habit_id = params.fetch("habit_id")
    user_id = current_user.id
    date = Date.parse(params.fetch("date"))

    if date > Date.current
      redirect_back(fallback_location: "/habits")
      return
    end

    day_entry = DayEntry.where({ :date => date, :user_id => user_id }).first

    if day_entry.nil?
      day_entry = DayEntry.new
      day_entry.user_id = user_id
      day_entry.date = date
      day_entry.highlight_of_the_day = ""
      day_entry.save
    end

    habit_check = HabitCheck.where({
      :habit_id => habit_id,
      :day_entry_id => day_entry.id,
      :user_id => user_id
    }).first

    if habit_check.nil?
      habit_check = HabitCheck.new
      habit_check.user_id = user_id
      habit_check.habit_id = habit_id
      habit_check.day_entry_id = day_entry.id
    end

    habit_check.completed = (params.fetch("completed") == "true")
    habit_check.save

    redirect_back(fallback_location: "/habits")
  end

  def create
    the_habit_check = HabitCheck.new
    the_habit_check.user_id = current_user.id
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
    the_habit_check = current_user.habitchecks.where({ :id => the_id }).at(0)

    the_habit_check.user_id = current_user.id
    the_habit_check.habit_id = params.fetch("query_habit_id")
    the_habit_check.completed = params.fetch("query_completed")
    the_habit_check.day_entry_id = params.fetch("query_day_entry_id")

    if the_habit_check.valid?
      the_habit_check.save
      redirect_to("/habit_checks/#{the_habit_check.id}", { :notice => "Habit check updated successfully." })
    else
      redirect_to("/habit_checks/#{the_habit_check.id}", { :alert => the_habit_check.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_habit_check = current_user.habitchecks.where({ :id => the_id }).at(0)

    the_habit_check.destroy

    redirect_to("/habit_checks", { :notice => "Habit check deleted successfully." })
  end
end
