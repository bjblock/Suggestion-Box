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
      flash[:neg_notice] = 'Sorry, you must first sign in.'
      redirect_to new_session_url
    end
  end
  
  # def require_logout
  #   if session[:user_id].present?
  #     redirect_to root_url, :notice => 'Oops, you\'re already logged in'.
  #   end
  # end
  
  def require_admin
    if @current_user.administrator?
      return
    else
      flash[:neg_notice] = 'Sorry, permission denied.'
      redirect_to root_url
    end
  end
  
  def require_permission
    
  end
  
  def find_suggestion_box
    if params[:suggestion_box_id].present?
      @suggestion_box = SuggestionBox.find(params[:suggestion_box_id])
    else
      @suggestion_box = SuggestionBox.find(params[:id])
    end
  end
  
end
