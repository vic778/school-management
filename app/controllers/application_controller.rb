class ApplicationController < ActionController::Base
  include Pundit::Authorization
  respond_to :json, :html

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  skip_before_action :verify_authenticity_token
  protect_from_forgery with: :null_session
  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name])
  end

  def user_not_authorized
    render json: { error: 'You are not authorized to perform this action' }, status: :unauthorized
  end
end
