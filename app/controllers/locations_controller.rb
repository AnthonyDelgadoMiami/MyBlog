class LocationsController < ApplicationController
  before_action :set_location, only: [:show, :edit, :update]
  
  def index
    @locations = Location.all
      
    if params[:search] && (params[:search] != '')
      @locations = @locations.search(params[:search])
      logger.debug '********&&&&*********'
    end

    sortColNames = %w[id name]

    if params[:sort].present? && sortColNames.include?(params[:sort])
      sort_direction = params[:direction] == 'desc' ? 'desc' : 'asc'
      @locations = @locations.order(params[:sort] +" " + sort_direction)
      @sort_column = params[:sort]
      @sort_direction = sort_direction
    end
    
  end
  
  def show
    logger.debug '*************DEBUGGA*******'
    @location = Location.find(params[:id])
  end

  def new
    @location = Location.new
  end

  def edit
    logger.debug '***************passed edit***'
    @location = Location.find(params[:id])
  end

  def create
    logger.debug '***********CREATION WENT THROUGH***'
    logger.debug params.inspect
    @locations = Location.new(location_params)
    if @locations.save
      flash[:success] = 'User added'
      redirect_to locations_path
    else
      flash[:error] = 'Something went wrong, please try again'
      render 'new'
    end
  end

  def update
    @locations = Location.find(params[:id])
    if @locations.update(location_params)
      redirect_to locations_path
    else
      render 'edit'
    end
  end


  def destroy
    if params[:locations].nil?
      return nil
      redirect_to locations_path
    end
    logger.debug '*********GOING THROUGH DELETE*****'
    @locations = Location.find(params[:locations])
    @locations.each do |locations|
      if locations.destroy
        flash[:success] = 'The user account has been deleted.'
      else
        flash.now[:error] = 'Sorry, user record was not changed.'
      end
    end
    redirect_to locations_path
  end

  def destroy_multiple
    logger.debug '********PASSING MULTIPLE***'
    if params[:locations]
      Location.destroy(params[:locations])
    end
    respond_to do |format|
      format.html { redirect_to locations_path }
      format.json { head :no_content }
    end
  end

  private

  def set_location
    @locations = Location.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def location_params
    params.require(:location).permit(:name)
  end
  

  
end