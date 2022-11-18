class ConfirmationsController < Devise::ConfirmationsController
  respond_to :json, :html

  def show
    self.resource = User.confirm_by_token(params[:confirmation_token])

    yield resource if block_given?

    if Rails.env.development?
      if resource.errors.empty?
        @current_user = resource
        if @current_user
          # Profile.new(first_name: @current_user.first_name, last_name: @current_user.last_name,
          #             user_id: @current_user.id).save
          redirect_to "http://localhost:3000/api/users/login"
          # render json: {message: "Email confirmation successful @#{@current_user.username}, go to JUUBIX website and login" }
        end
      else
        render json: { error: "This confirmation link has expired" }
      end
    elsif Rails.env.production?
      if resource.errors.empty?
        @current_user = resource
        if @current_user
          redirect_to "http://localhost:3000/"
          # render json: {message: "Email confirmation successful @#{@current_user.username}, go to JUUBIX website and login" }
        end
      else
        render json: { error: "This confirmation link has expired" }
      end
    end
  end
end
