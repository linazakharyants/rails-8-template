class ProfilesController < ApplicationController
  before_action :authenticate_user!

  def edit
    @the_user = current_user
    render({ :template => "profile_templates/edit" })
  end

  def update
  the_user = current_user
  the_user.name = params[:query_name]

  if params[:query_avatar].present?
    the_user.avatar.attach(params[:query_avatar])
  end

  if the_user.save
    redirect_to "/profile", notice: "Profile updated."
  else
    redirect_to "/profile", alert: the_user.errors.full_messages.to_sentence
  end
end
end
