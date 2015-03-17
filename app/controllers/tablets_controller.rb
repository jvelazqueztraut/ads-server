require 'securerandom'

class TabletsController < SecurityController
  before_action :set_tablet, only: [:show]

  skip_before_action :authenticate_request!, only: [:create]
  before_action :authenticate_create!, only: [:create]

  # GET /tablets
  # GET /tablets.json
  def index
    @tablets = Tablet.all
  end

  # GET /tablets/1
  # GET /tablets/1.json
  def show
  end

  # POST /tablets
  # POST /tablets.json
  def create
    salt = SecureRandom.base64
    token = Tablet.salt_that_token(tablet_params[:flash_token], salt)

    @tablet = Tablet.find_by(uuid: tablet_params[:uuid])
    @tablet ||= Tablet.new(tablet_params)

    @tablet.update(flash_token: token)
    @tablet.update(salt: salt)

    respond_to do |format|
      if @tablet.save
        format.json { render json: { tablet_id: @tablet.id, flash_token: @tablet.flash_token }, status: :ok }
      else
        format.json { render json: @tablet.errors, status: :unprocessable_entity }
      end
    end
  end

  def user_tablets
    respond_to do |format|
      if current_user.tablets.count == 0
        format.json { render json: Array.new }
      else
        tablets_with_location = Array.new
        current_user.tablets.each do |t|
          if t.locations
            tablets_with_location.push t
          end
        end
        format.json { render json: tablets_with_location.to_json(:include => :locations) }
      end
    end
  end

  def update_location
    loc = Location.create(tablet_params[:location])
    p tablet_params[:location]
    current_tablet.locations << loc
    
    respond_to do |format|
      if current_tablet.save
        format.json { render json: "Ok", status: :ok }
      else
        format.json { render json: current_tablet.errors, status: :unprocessable_entity }
      end
    end

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tablet
      @tablet = Tablet.find(params[:tablet_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tablet_params
      params.require(:tablet).permit(:uuid, :flash_token, :salt, :flash_date, :user_id, :location => [:latitude, :longitude, :altitude, :speed, :accuracy, :is_gps_provider, :date])
    end
end
