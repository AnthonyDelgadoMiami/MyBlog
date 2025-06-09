
class RelationshipsController < ApplicationController
  before_action :require_user

  def create
    user = User.find(params[:followed_id])
    current_user.follow(user)
    flash[:notice] = "You are now following #{user.username}"
    redirect_to user
  end

  def destroy
    user = User.find(params[:id])
    current_user.unfollow(user)
    flash[:notice] = "You unfollowed #{user.username}"
    redirect_to user
  end
end
