class UsersController < PermissionsController
  before_action :authenticate_user!
  before_action :only_teacher, only: %i[update destroy show]

  def show
    user = User.find_by(id: params[:user_id])
    if user
      render json: user
    else
      render json: { error: "User not found" }
    end
  end

  def update
    user = User.find_by(id: params[:user_id])
    if user.save
      user.update(user_params)
      render json: user
    else
      render json: { error: "User not found" }
    end
  end

  def destroy
    user = User.find_by(id: params[:user_id])
    if user.destroy
      render json: { message: "User deleted" }
    else
      render json: { error: "User not found" }
    end
  end

  def auto_login
    render json: {
      user: current_user
    }
  end

  private

  def user_params
    params.permit(:name, :email, :password, :password_confirmation, :role_id)
  end
end
