class SessionsController < ApplicationController

  def new
    redirect_to home_path if current_user
  end

  def create
    user = User.find_by(email: params[:email])
    
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "Welcome back #{user.name}!"
      redirect_to home_path
    else
      flash[:warning] = "Oops! Invalid username or password, try again."
      redirect_to sign_in_path
    end
  end
  
  def destroy
    flash[:success] = "See you soon!"
    session[:user_id] = nil
    redirect_to root_path
  end

end