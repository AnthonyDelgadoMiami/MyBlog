class RelationshipsController < ApplicationController
  before_action :require_user
  def create
    user = User.find(params[:id])
    current_user.follow(user)
    flash[:notice] = "You are now following #{user.name}"
    redirect_to user_path(user)
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = 'User not found.'
    redirect_to users_path
  end

  def destroy
    user = User.find(params[:id])
    current_user.unfollow(user)
    flash[:notice] = "You have unfollowed #{user.name}."
    redirect_to users_path
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = 'User not found.'
    redirect_to users_path
  end
end
