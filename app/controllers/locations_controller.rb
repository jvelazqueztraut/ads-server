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
    loc = Location.create(location_params)
    current_tablet.locations << loc

    respond_to do |format|
      if current_tablet.save
        format.json { render :show, status: :created, location: loc }
      else
        format.json { render json: current_tablet.errors, status: :unprocessable_entity }
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
      params.require(:location).permit(:latitude, :longitude, :altitude, :speed, :accuracy, :is_gps_provider, :date)
    end
end
