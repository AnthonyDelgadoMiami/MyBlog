class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  before_action :require_user, except: [:new, :create, :show]
  before_action :require_same_user, only: [:edit, :update]

  def index
    @users = User.all

    if params[:search] && (params[:search] != '')
      @users = @users.search(params[:search])
    end

    @users = @users.order(:name)
  end

  def show
    @posts = @user.posts.recent.limit(20)
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = 'Welcome to the social platform!'
      redirect_to root_path
    else
      render 'new'
    end
  end

  def update
    # Remove password from params if it's blank
    update_params = user_params
    if update_params[:password].blank?
      update_params = update_params.except(:password)
    end
    
    if @user.update(update_params)
      flash[:notice] = "Your account was updated successfully"
      redirect_to @user
    else
      render 'edit'
    end
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
      flash[:alert] = "You can only edit your own account"
      redirect_to @user
    end
  end
end