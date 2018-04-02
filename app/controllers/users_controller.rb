class UsersController < ApplicationController
  before_action :set_user, except: :index
  skip_before_action :authenticate_user!, only: :index

  def index
    @users = User.all
  end

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: 'User was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to users_path, notice: 'User was successfully destroyed'
  end

  private

  def user_params
    params.require(:user).permit(:login, :first_name, :last_name,
                                 :birthday, :email, :address, :city,
                                 :state, :country, :zip, :role)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
