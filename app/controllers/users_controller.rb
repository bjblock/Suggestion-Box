class UsersController < ApplicationController

  before_filter :require_login, :except => [:new, :create]
  # before_filter :require_logout, :only => [:new, :create]
  before_filter :require_admin, :only => :index
  before_filter :require_user_permission, :except => [:index, :new, :create]
  
  def require_user_permission
    @user = User.find(params[:id])
    if @user == @current_user
      return
    else
      flash[:neg_notice] = 'Sorry, permission denied.'
      redirect_to root_url
    end
  end

  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  def show
    # @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  def edit
    # @user = User.find(params[:id])
  end

  def create
    @user = User.new(params[:user])

    if @user.save
      session[:user_id] = @user.id
      flash[:pos_notice] = "Thanks for signing up!"
      redirect_to root_url
    else
      flash[:neg_notice] = "Please try again."
      render :new
    end
  end

  def update
    # @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    # @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end
end
