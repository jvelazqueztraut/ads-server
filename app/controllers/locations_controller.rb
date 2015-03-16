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
    locations = current_tablet.locations ||= Array.new
    loc = Location.new(location_params)
    locations << loc

    respond_to do |format|
      if current_tablet.update(locations: locations)
        format.json { render :show, status: :created, location: loc }
      else
        format.json { render json: locations.errors, status: :unprocessable_entity }
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
      params.require(:location).permit(:tablet_id, :latitude, :longitude, :altitude, :speed, :accuracy, :is_gps_provider, :date)
    end
end
