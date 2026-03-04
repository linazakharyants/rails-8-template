Rails.application.routes.draw do

  get("/", { :controller => "calendar", :action => "index"})
  get("/calendar", { :controller => "calendar", :action => "index"})

  #daily entries
  get("/highlights/:date", { :controller => "day_entries", :action => "edit_highlight" })
  post("/upsert_highlight/:date", { :controller => "day_entries", :action => "upsert_highlight" })

  #habits
  get("/frames/:path_id", { :controller => "day_entries", :action => "edit_frame" })
  post("/modify_frame/:path_id", { :controller => "day_entries", :action => "update_frame" })


  post("/insert_habit", { :controller => "habits", :action => "create" })
  get("/habits", { :controller => "habits", :action => "index" })
  
  get("/habits/:path_id", { :controller => "habits", :action => "show" })
  get("/habits_manage", { :controller => "habits", :action => "manage" })
  post("/modify_habit/:path_id", { :controller => "habits", :action => "update" })
  get("/delete_habit/:path_id", { :controller => "habits", :action => "destroy" })

  # Routes for the Day entry resource:

  # CREATE
  post("/insert_day_entry", { :controller => "day_entries", :action => "create" })
  

  # Routes for the Note resource:

  # CREATE
  post("/insert_note", { :controller => "notes", :action => "create" })

  # READ
  get("/notes", { :controller => "notes", :action => "index" })

  get("/notes/:path_id", { :controller => "notes", :action => "show" })

  # UPDATE

  post("/modify_note/:path_id", { :controller => "notes", :action => "update" })

  # DELETE
  get("/delete_note/:path_id", { :controller => "notes", :action => "destroy" })

  #------------------------------

  # Routes for the Habit check resource:

  # CREATE
  post("/insert_habit_check", { :controller => "habit_checks", :action => "create" })

  # READ
  get("/habit_checks", { :controller => "habit_checks", :action => "index" })

  get("/habit_checks/:path_id", { :controller => "habit_checks", :action => "show" })

  # UPDATE

  post("/modify_habit_check/:path_id", { :controller => "habit_checks", :action => "update" })

  # DELETE
  get("/delete_habit_check/:path_id", { :controller => "habit_checks", :action => "destroy" })

  #------------------------------

  # Routes for the Habit resource:

  # CREATE
  post("/insert_habit", { :controller => "habits", :action => "create" })

  # READ
  get("/habits", { :controller => "habits", :action => "index" })

  get("/habits/:path_id", { :controller => "habits", :action => "show" })

  # UPDATE

  post("/modify_habit/:path_id", { :controller => "habits", :action => "update" })

  # DELETE
  get("/delete_habit/:path_id", { :controller => "habits", :action => "destroy" })

  #------------------------------

  # UPDATE

  post("/modify_day_entry/:path_id", { :controller => "day_entries", :action => "update" })

  # DELETE
  get("/delete_day_entry/:path_id", { :controller => "day_entries", :action => "destroy" })

  #------------------------------

  #devise_for :users
  # This is a blank app! Pick your first screen, build out the RCAV, and go from there. E.g.:
  # get("/your_first_screen", { :controller => "pages", :action => "first" })
end
