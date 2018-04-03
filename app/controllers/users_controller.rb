class UsersController < ApplicationController

  before_action :valid_user, only:[:edit,:update,:show,:deactivate]
  before_action :logged_in_user, only: [:edit, :update, :show,:deactivate,:index]
  before_action :user_permission, only: [:edit,:update,:show,:deactivate]


  def index
    @users = User.order("score DESC").paginate(page: params[:page])
  end

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_path
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Your profile has been successfully updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def deactivate
    @user = User.where(id: params[:id]).first
    if(current_user == @user)
      @user.update_attributes(active: false)
      flash[:success] = "User Deactivated!!"
      log_out
      redirect_to root_path
    end

  end



  private

  def user_params
    params.require(:user).permit(:first_name, :last_name,:username,:email, :password,
                                 :password_confirmation, :score)
  end

  def logged_in_user
    unless logged_in?
      remember_location
      flash[:danger] = "Please log in."
      redirect_to login_path
    end
  end

  def user_permission
    @user = User.where(id: params[:id]).first
    if  !(@user == current_user)
      flash[:danger] = "You are not authorized"
      redirect_to root_path
    end

  end

  def valid_user
    @user = User.where(id: params[:id]).first
    if @user.nil?
      redirect_to root_path
    end
  end





end
