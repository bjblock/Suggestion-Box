class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def check_for_user
    if session[:user_id].present?
      @current_user = User.find(session[:user_id])
    end
  end
  
  def require_login
    if session[:user_id].present?
      @current_user = User.find(session[:user_id])
      return
    else
      redirect_to new_session_url, :notice => 'Sorry, you must first sign in.'
    end
  end
  
  # def require_logout
  #   if session[:user_id].present?
  #     redirect_to root_url, :notice => 'Oops, you\'re already logged in'.
  #   end
  # end
  
  def find_suggestion_box
    @suggestion_box = SuggestionBox.find(params[:suggestion_box_id])
  end
  
end
