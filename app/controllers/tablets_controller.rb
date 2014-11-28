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
    tablet_params[:salt] = SecureRandom.base64
    tablet_params[:flash_token] = Tablet.salt_that_token(tablet_params[:flash_token], tablet_params[:salt])
    @tablet = Tablet.new(tablet_params)

    respond_to do |format|
      if @tablet.save
        format.json { render :show, status: :created, location: @tablet }
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
        format.json { render json: current_user.tablets }
      end
    end
  end

  def location_for_tablet
    respond_to do |format|
      if current_user.tablets.count == 0 || current_user.tablets.where(id: params[:tablet_id]).count == 0
        format.json { render json: "Tablet not found!", status: :unprocessable_entity }
      else
        tablet = current_user.tablets.where(id: params[:tablet_id]).first
        format.json { render json: tablet }
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
      params.require(:tablet).permit(:uuid, :flash_token, :salt, :flash_date, :user_id)
    end
end
