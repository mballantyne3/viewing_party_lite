# frozen_string_literal: true

class UsersController < ApplicationController
  def index; end

  def show
    @user = User.find(session[:user_id])
  end

  def discover
    @user = User.find(session[:user_id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to '/dashboard'
      session[:user_id] = @user.id
      flash[:success] = "Welcome, #{@user.name}!"
    else
      flash[:error] = @user.errors.full_messages
      redirect_to '/register'
    end
  end

  def login_form
    render :login_form
  end

  def login_user
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      redirect_to '/dashboard'
      session[:user_id] = @user.id
      flash[:success] = "Welcome back #{@user.name}"
    else
      flash[:error] = "Invalid email/password"
      render :login_form
    end
  end

  def logout_user
    user = User.find_by(email: params[:email])
    #currently not sure how to verify if a user is logged in, maybe use:
    # if session[:user_id] = user.id
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
