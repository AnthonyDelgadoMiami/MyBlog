class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update]
  before_action :require_user, except: %i[new create show]
  before_action :require_same_user, only: %i[edit update]

  def index
    @users = User.all
    @users = @users.where('name LIKE ?', "%#{params[:search]}%") if params[:search].present?
    if current_user
      @users = @users.where.not(id: current_user.id)
      @users = @users.order(:name)
    else
      @users = @users.order(:name)
    end
  end

  def show
    @posts = @user.posts.recent.limit(20)
  end

  def new
    @user = User.new
  end

  def edit; end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = 'Welcome to MyBlog!'
      redirect_to root_path
    else
      render 'new'
    end
  end

  def update
    update_params = user_params
    update_params = update_params.except(:password) if update_params[:password].blank?

    if @user.update(update_params)
      flash[:notice] = 'Your account was updated successfully'
      redirect_to @user
    else
      render 'edit'
    end
  end

  def follow_user
    user_to_follow = User.find(params[:id])
    current_user.follow(user_to_follow)
    flash[:notice] = "You are now following #{user_to_follow.name}."
    redirect_to users_path
  end

  def following
    @user = User.find(params[:id])
    @following = @user.following
  end

  def followers
    @user = User.find(params[:id])
    @followers = @user.followers
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :username, :email, :password)
  end

  def require_same_user
    if current_user != @user
      flash[:alert] = 'You can only edit your own account'
      redirect_to @user
    end
  end
end
