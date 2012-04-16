class SuggestionBoxesController < ApplicationController

  before_filter :check_for_user
  before_filter :require_login, :only => [:new, :create, :edit, :update, :destroy]
  before_filter :require_suggestion_box_creator_or_admin, :only => [:edit, :update, :destroy, :close, :open]
  before_filter :require_invitation_key, :only => :show
  
  def require_suggestion_box_creator_or_admin
    @suggestion_box = SuggestionBox.find(params[:id])
    if (@suggestion_box.user == @current_user) || (@current_user.administrator?)
      return
    else
      flash[:neg_notice] = 'Sorry, permission denied.'
      redirect_to root_url
    end
  end
    
  def require_invitation_key
    @suggestion_box = SuggestionBox.find(params[:id])
    if @suggestion_box.by_invite_only? && @suggestion_box.invitation_keys.present?
      if (session[:invitation_key].present? && @suggestion_box.invitation_keys.find_by_key(session[:invitation_key]).present?)
        return
      elsif session[:user_id].present? && ((@suggestion_box.user == @current_user) || @current_user.administrator?)
        return
      else
        flash[:neg_notice] = 'Sorry, you must first enter a valid invitation key.'
        redirect_to check_key_suggestion_box_url 
      end
    else
      return
    end
  end

  def index
    @open_suggestion_boxes = SuggestionBox.where('open = ?', true).page(params[:page]).per(5)
    @all_suggestion_boxes = SuggestionBox.page(params[:page]).per(5)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @suggestion_boxes }
    end
  end

  def show
    @suggestion_box = SuggestionBox.find(params[:id])
    @suggestion = Suggestion.new
    @suggestions = @suggestion_box.suggestions.order("created_at DESC") # .page(params[:page]).per(5)
    @vote = Vote.new

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @suggestion_box }
    end
  end

  def new
    @suggestion_box = SuggestionBox.new
    
    @suggestion_box.invitation_keys.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @suggestion_box }
    end
  end

  def edit
    @suggestion_box = SuggestionBox.find(params[:id])
  end

  def create
    @suggestion_box = SuggestionBox.new(params[:suggestion_box])

    respond_to do |format|
      if @suggestion_box.save
        if @suggestion_box.by_invite_only?
          flash[:pos_notice] = 'Suggestion Box was successfully created. Now limit access by creating a password'
          format.html { redirect_to suggestion_box_new_invitation_key_url(@suggestion_box) }
        else
          format.html { redirect_to @suggestion_box, notice: 'Suggestion box was successfully created.' }
          format.json { render json: @suggestion_box, status: :created, location: @suggestion_box }
        end
      else
        format.html { render action: "new" }
        format.json { render json: @suggestion_box.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @suggestion_box = SuggestionBox.find(params[:id])

    respond_to do |format|
      if @suggestion_box.update_attributes(params[:suggestion_box])
        format.html { redirect_to @suggestion_box, notice: 'Suggestion box was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @suggestion_box.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @suggestion_box = SuggestionBox.find(params[:id])
    @suggestion_box.destroy

    respond_to do |format|
      format.html { redirect_to suggestion_boxes_url }
      format.json { head :no_content }
    end
  end
  
  def close
    @suggestion_box = SuggestionBox.find(params[:id])
    @suggestion_box.open = false
    @suggestion_box.save
    
    flash[:neg_notice] = 'This Suggestion Box is now closed and is now only viewable by you.'
    redirect_to @suggestion_box
  end
  
  def open
    @suggestion_box = SuggestionBox.find(params[:id])
    @suggestion_box.open = true
    @suggestion_box.save
    
    flash[:pos_notice] = 'This Suggestion Box is now open.'
    redirect_to @suggestion_box
  end
  
  def check
    @suggestion_box = SuggestionBox.find(params[:id])
  end
  
  def permission
    @suggestion_box = SuggestionBox.find(params[:id])
    if params[:key].present? && @suggestion_box.invitation_keys.find_by_key(params[:key]).present?
      if session[:invitation_key].nil?
        session[:invitation_key] = []
      end
      session[:invitation_key] << @suggestion_box.invitation_keys.find_by_key(params[:key]).key
      redirect_to suggestion_box_url(@suggestion_box)
    else
      flash[:neg_notice] = 'Sorry, you must first enter a valid invitation key.'
      redirect_to check_key_suggestion_box_url
    end
  end
    
end
