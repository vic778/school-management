module Auth
  extend ActiveSupport::Concern

  def authenticate_user!
    u = User.find_by(email: request.headers['X-User-Email'])
    if @current_user.nil?
      render json: { error: "You need to sign in or sign up before continuing." }, status: :unauthorized
      p "here is the current user#{@current_user}"
    else
      action = params[:action]
      resource = params[:controller].split('/').last.singularize
      render json: { error: "You don't have the permission to perform this action" }, status: :unauthorized unless @current_user.has_permission?(action, resource)
    end
  end
end
