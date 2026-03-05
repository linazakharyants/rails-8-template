class ProfilesController < ApplicationController
  before_action :authenticate_user!

  def edit
    @the_user = current_user
    render({ :template => "profile_templates/edit" })
  end

  def update
    the_user = current_user

    the_user.name = params.fetch("query_name", "")
    the_user.avatar = params.fetch("query_avatar", "")

    if the_user.valid?
      the_user.save
      redirect_to("/profile", { :notice => "Profile updated." })
    else
      redirect_to("/profile", { :alert => the_user.errors.full_messages.to_sentence })
    end
  end
end
