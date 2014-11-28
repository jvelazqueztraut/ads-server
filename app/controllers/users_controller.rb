class UsersController < SecurityController
  before_action :set_user, only: [:show, :update]

  skip_before_action :authenticate_request!, only: [:create]
  before_action :authenticate_create!, only: [:create]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # POST /users
  # POST /users.json
  def create
    token = OpenSSL::Digest::SHA256.new(SecureRandom.hex).to_s
    @user = User.find_by(email: user_params[:email])
    @user ||= User.new(user_params)

    @user.update(token: token)

    respond_to do |format|
      if @user.save
        format.json { render json: { user_id: @user.id, token: @user.token }, status: :ok }
      else
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def associate_tablet
    t = Tablet.find_by(uuid: params[:uuid])
    if t
      if t.update(user_id: current_user.id)
        format.json { render :show, status: :ok, location: current_user }
      else
        format.json { render json: current_user.errors, status: :unprocessable_entity }
      end
    else
        format.json { render json: "Tablet not found!", status: :unprocessable_entity }
    end
  end

  def deassociate_tablet
    t = Tablet.find_by(uuid: params[:uuid])
    if t
      if t.update(user_id: nil)
        format.json { render :show, status: :ok, location: current_user }
      else
        format.json { render json: current_user.errors, status: :unprocessable_entity }
      end
    else
        format.json { render json: "Tablet not found!", status: :unprocessable_entity }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:email, :token)
    end
end
