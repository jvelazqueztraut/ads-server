class AdsController < SecurityController
  before_action :set_ad, only: [:show, :edit, :update, :destroy]
  skip_before_filter :authenticate_tablet!

  # GET /ads
  # GET /ads.json
  def index
    @ads = Ad.all
    respond_to do |format|
      format.html { render :index }
      if (@ads.count == 0)
        format.json { Array.new }
      else
        format.json { @ads }
      end
    end
  end

  # GET /ads/1
  # GET /ads/1.json
  def show
    render :edit
  end

  # GET /ads/new
  def new
    @ad = Ad.new
  end

  # GET /ads/1/edit
  def edit
  end

  # POST /ads
  # POST /ads.json
  def create
    @ad = Ad.new(ad_params)

    respond_to do |format|
      if @ad.save
        format.html { redirect_to action: :index, notice: 'Ad was successfully created.' }
        format.json { render :index, status: :created }
      else
        format.html { render :new }
        format.json { render json: @ad.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ads/1
  # PATCH/PUT /ads/1.json
  def update
    respond_to do |format|
      if @ad.update(ad_params)
        format.html { redirect_to action: :index, notice: 'Ad was successfully updated.' }
        format.json { render :index, status: :ok, location: @ad }
      else
        format.html { render :edit }
        format.json { render json: @ad.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ads/1
  # DELETE /ads/1.json
  def destroy
    @ad.destroy
    respond_to do |format|
      format.html { redirect_to ads_url, notice: 'Ad was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ad
      @ad = Ad.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ad_params
      params.require(:ad).permit(:picture_url, :destination_url, :description)
    end
end
