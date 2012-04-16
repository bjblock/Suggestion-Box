class SuggestionsController < ApplicationController

  before_filter :check_for_user
  before_filter :require_login, :except => :create
  # before_filter :require_admin, :except => :create
  before_filter :require_suggestion_box_creator_or_admin, :except => :create
  before_filter :find_suggestion_box
  
  def require_suggestion_box_creator_or_admin
    @suggestion_box = SuggestionBox.find(params[:suggestion_box_id])
    if (@suggestion_box.user == @current_user) || (@current_user.administrator?)
      return
    else
      flash[:neg_notice] = 'Sorry, permission denied.'
      redirect_to root_url
    end
  end
  
  def index
    @suggestions = Suggestion.all
    # @suggestion_box = SuggestionBox.find(params[:suggestion_box_id])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @suggestions }
    end
  end

  def show
    @suggestion = Suggestion.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @suggestion }
    end
  end

  def new
    @suggestion = Suggestion.new
    # @suggestion_box = SuggestionBox.find(params[:suggestion_box_id])

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @suggestion }
    end
  end

  def edit
    @suggestion = Suggestion.find(params[:id])
  end

  def create
    @suggestion = Suggestion.new(params[:suggestion])
    # @suggestion_box = SuggestionBox.find(params[:suggestion_box_id])
    @suggestion_box = SuggestionBox.find(params[:suggestion_box_id])
    @vote = Vote.new

    respond_to do |format|
      if @suggestion.save
        format.js
        format.html { redirect_to suggestion_box_url(@suggestion_box), notice: 'Suggestion was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  def update
    @suggestion = Suggestion.find(params[:id])

    respond_to do |format|
      if @suggestion.update_attributes(params[:suggestion])
        format.html { redirect_to suggestion_box_suggestion_url(@suggestion_box, @suggestion), notice: 'Suggestion was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @suggestion.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @suggestion = Suggestion.find(params[:id])
    @suggestion.destroy

    respond_to do |format|
      format.html { redirect_to suggestion_box_suggestions_url(@suggestion.suggestion_box) }
      format.json { head :no_content }
    end
  end
end
