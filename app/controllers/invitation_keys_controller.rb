class InvitationKeysController < ApplicationController
  
  before_filter :require_login
  before_filter :require_invitation_key_permission
  
  def require_invitation_key_permission
    @suggestion_box = SuggestionBox.find(params[:suggestion_box_id])
    if @suggestion_box.user == !@current_user
      flash[:neg_notice] = 'Sorry, permission denied.'
      redirect_to root_url
    else
      return
    end
  end
  
  def new
    @invitation_key = InvitationKey.new
    # @suggestion_box = Suggestion.find(params[:suggestion_box_id])
  end
  
  def create
    @invitation_key = InvitationKey.new(params[:invitation_key])
    @invitation_key.save
    redirect_to suggestion_box_url(@suggestion_box), notice: 'Suggestion Box invitation key has been saved.'
  end
  
  def reset
    @invitation_keys = @suggestion_box.invitation_keys
    @invitation_keys.destroy_all
    
    flash[:neg_notice] = 'Suggestion Box invitation keys have been reset. Enter a new key below.'
    redirect_to suggestion_box_new_invitation_key_url
  end
  
end
