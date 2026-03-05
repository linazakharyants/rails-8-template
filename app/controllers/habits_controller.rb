class HabitsController < ApplicationController
  def index
  user_id = 1

  today = Date.today
  @start_date = today.beginning_of_week(:monday)
  @end_date = @start_date + 6
  @dates = (@start_date..@end_date).to_a

  @list_of_habits = Habit.order({ :created_at => :desc })
  habits_count = @list_of_habits.count

  # Get day entries for the week (map day_entry_id -> date)
  week_entries = DayEntry.where({
    :user_id => user_id,
    :date => @start_date..@end_date
  })

  day_entry_date_by_id = {}
  week_entries.each do |de|
    day_entry_date_by_id[de.id] = de.date
  end

  day_entry_ids = day_entry_date_by_id.keys

  # Get habit checks for those day entries
  checks = HabitCheck.where({
    :user_id => user_id,
    :day_entry_id => day_entry_ids
  })

  # Build the hash the view expects: "#{habit_id}-#{date}" => true/false
  @checks_by_key = {}
  checks.each do |c|
    date = day_entry_date_by_id[c.day_entry_id]
    next if date.nil?
    @checks_by_key["#{c.habit_id}-#{date}"] = (c.completed == true)
  end

  # Weekly % progress
  if habits_count > 0
    completed_checks = checks.where({ :completed => true }).count
    total_possible = habits_count * 7
    percent = ((completed_checks.to_f / total_possible) * 100).round
    @habit_progress_text = "#{completed_checks}/#{total_possible} (#{percent}%)"
  else
    @habit_progress_text = "No habits yet"
  end

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

 def manage
  matching_habits = Habit.all
  @list_of_habits = matching_habits.order({ :created_at => :desc })
  
  render({ :template => "habit_templates/manage" })
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
