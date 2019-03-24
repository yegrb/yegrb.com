class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && (user.authenticate(params[:session][:password]) || Rails.env.development?)
      log_in user
      flash[:success] = "Welcome #{user.first_name}"
      redirect_to user
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    log_out
    flash[:success] = 'You have logged out'
    redirect_to root_url
  end
end
