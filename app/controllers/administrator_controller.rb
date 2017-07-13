class AdministratorController < ApplicationController
  authorize_resource :class => false

  def index
    @users = User.all
  end

  def create
    @user = User.new(administrator_params)
    @user.save
    redirect_to administrator_index_path
  end

  def new

  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(administrator_params)
    redirect_to administrator_index_path
  end

  def destroy
    User.destroy(params[:id])
    redirect_back(fallback_location: administrator_path)
  end

  private

  def administrator_params
    params.require(:user).permit(:email, :password, :password_confirmation, :admin_role, :supervisor_role, :user_role)
  end

end
