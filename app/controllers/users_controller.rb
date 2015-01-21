class UsersController < ApplicationController
  before_action :require_user, only: [:show, :people]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = "Welcome to MyFlix #{@user.name}!"
      session[:user_id] = @user.id
      redirect_to home_path
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def people

  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end

end
