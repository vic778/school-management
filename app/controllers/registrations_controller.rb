class RegistrationsController < Devise::RegistrationsController
  #   include Auth
  before_action :authenticate_user
  before_action :authenticate_user!
  before_action :only_teacher, only: %i[show update destroy create]
  def create
    # binding.pry
    user = User.new(user_params)
    if user.save
      render json: 'Thank you for joining Oivan platform, please check your email and verify your account!', status: :created
    else
      render json: { errors: user.errors.full_messages }
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :name)
  end

  def auth_header
    request.headers['Authorization']
  end

  def authenticate_user
    if request.headers['Authorization'].present?
      authenticate_or_request_with_http_token do |token|
        jwt_payload = JWT.decode(token, 'vicSecret', true, algorithm: 'HS256').first

        @current_user_id = jwt_payload['id']
      rescue JWT::ExpiredSignature, JWT::VerificationError, JWT::DecodeError
        render json: { error: "Unauthorized access" }, status: :unauthorized
      end
    end
  end

  def authenticate_user!(_options = {})
    render json: { loggedIn: false, result: [], message: 'Please log in to continue' } unless signed_in?
  end

  def current_user
    @current_user ||= super || User.find(@current_user_id)
  rescue StandardError
    head :unauthorized
  end

  def signed_in?
    @current_user_id.present?
  end

  def only_teacher
    if current_user.role.name == "teacher"
      action = params[:action]
    else
      render json: { error: "Only the teacher can perform this action" }, status: :unauthorized
    end
  end
end
