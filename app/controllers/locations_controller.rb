class LocationsController < SecurityController
  before_action :set_location, only: [:show]

  # GET /locations
  # GET /locations.json
  def index
    @locations = Location.all
  end

  # GET /locations/1
  # GET /locations/1.json
  def show
  end

  # POST /locations
  # POST /locations.json
  def create
    current_tablet.location = Location.new(location_params)

    respond_to do |format|
      if location.save
        format.json { render :show, status: :created, location: location }
      else
        format.json { render json: location.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_location
      @location = Location.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def location_params
      params.require(:location).permit(:a, :b, :date, :tablet_id)
    end
end
