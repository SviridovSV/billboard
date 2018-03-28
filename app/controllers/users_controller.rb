class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  skip_before_action :authenticate_user!, only: :index

  def index
    @users = User.all
  end

  def show
  end

  def edit
  end

  def update
    if @user.update(params[:user])
      redirect_to @user, notice: 'User was successfully updated.'
    else
      render :edit
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
