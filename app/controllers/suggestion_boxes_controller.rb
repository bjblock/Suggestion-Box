class SuggestionBoxesController < ApplicationController

  before_filter :check_for_user
  # before_filter :check_for_user
  before_filter :require_login, :only => [:new, :create, :edit, :update, :destroy]
  # before_filter :require_permission, :only => [:edit, :update, :destroy]

  def index
    @suggestion_boxes = SuggestionBox.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @suggestion_boxes }
    end
  end

  def show
    @suggestion_box = SuggestionBox.find(params[:id])
    @suggestion = Suggestion.new
    @vote = Vote.new
    @current_user = User.find(session[:user_id]) if session[:user_id].present?

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @suggestion_box }
    end
  end

  def new
    @suggestion_box = SuggestionBox.new

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
        format.html { redirect_to @suggestion_box, notice: 'Suggestion box was successfully created.' }
        format.json { render json: @suggestion_box, status: :created, location: @suggestion_box }
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
    
    redirect_to @suggestion_box, notice: 'This Suggestion Box is now closed and is now only viewable by you.'
  end
  
  def open
    @suggestion_box = SuggestionBox.find(params[:id])
    @suggestion_box.open = true
    @suggestion_box.save
    
    redirect_to @suggestion_box, notice: 'This Suggestion Box is now open.'
  end
  
end
