class UsersController < ApplicationController
  # before_action :set_user, only: %i[ show edit update destroy ]
  #layout "lay"
  # GET /users or /users.json
  def index
    @user = User.includes(:location) #load model with eager-loading location
    
    if params[:search] && (params[:search] != '')
      @user = @user.search(params[:search])
      logger.debug '********&&&&*********'
    end

    sortColNames = %w[id name email]

    if params[:sort].present? && sortColNames.include?(params[:sort])
      sort_direction = params[:direction] == 'desc' ? 'desc' : 'asc'
      @user = @user.order(params[:sort] +" " + sort_direction)
      @sort_column = params[:sort]
      @sort_direction = sort_direction
    end

    @user.all
    
  end

  # GET /users/1 or /users/1.json
  def show
    logger.debug '*************DEBUGGA*******'
    @user = User.find(params[:id])
  end

  # GET /users/new
  def new
    @user = User.new
    @locations = Location.all
    
  end

  # GET /users/1/edit
  def edit
    @locations = Location.all
    logger.debug '***************passed edit***'
    @user = User.find(params[:id])
  end

  # POST /users or /users.json
  def create
    @locations = Location.all
    logger.debug '***********CREATION WENT THROUGH***'
    logger.debug params.inspect
    @user = User.new(user_params)
    if @user.save
      flash[:success] = 'User added'
      redirect_to root_path
    else
      flash[:error] = 'Something went wrong, please try again'
      render 'new'
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    @locations = Location.all
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to root_path
    else
      render 'edit'
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    if params[:users].nil?
      return nil
      redirect_to root_path
    end
    logger.debug '*********GOING THROUGH DELETE*****'
    @user = User.find(params[:users])
    @user.each do |users|
      if users.destroy
        flash[:success] = 'The user account has been deleted.'
      else
        flash.now[:error] = 'Sorry, user record was not changed.'
      end
    end
    redirect_to root_path
  end

  def destroy_multiple
    logger.debug '********PASSING MULTIPLE***'
    if params[:users]
      User.destroy(params[:users])
    end
    respond_to do |format|
      format.html { redirect_to users_path }
      format.json { head :no_content }
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:name, :email, :location_id)
  end
end
