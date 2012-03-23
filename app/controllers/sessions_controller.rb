class SessionsController < ApplicationController
  
  def new
    if session[:user_id].present?
      redirect_to root_url, :notice => 'Oops, you\'re already signed in.'
    end
  end
  
  def create
    user = User.find_by_email(params[:email])
    if user.present? && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_url, :notice => 'Welcome!'
    else
      render :new, :notice => 'Please try again.'
    end
  end
  
  def destroy
    reset_session
    redirect_to root_url, :notice => 'See ya!'
  end
  
end
