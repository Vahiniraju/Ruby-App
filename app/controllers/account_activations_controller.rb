class AccountActivationsController < ApplicationController

  def edit
    user = User.find_by(email: params[:email])
    if user && !user.active? && user.authenticated?(:activation, params[:id])
      user.activate
      login(user)
      flash[:success] = "Account Activated!"
      redirect_to user
    else
      flash[:danger] = "Invalid activation link"
      redirect_to root_path
    end
  end
end
