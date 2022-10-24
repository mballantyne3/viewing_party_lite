# frozen_string_literal: true

class UsersController < ApplicationController
  def index; end

  def show
    @user = User.find(params[:id])
  end

  def discover
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to user_path(@user.id)
      flash[:success] = "Welcome, #{@user.name}!"
    else
      flash[:error] = @user.errors.full_messages
      redirect_to '/register'
    end
  end

  def login_form
  end

  def login_user
    @user = User.find_by(email: params[:email])
    if @user.authenticate(params[:password])
      redirect_to user_path(@user.id)
      flash[:success] = "Welcome back #{@user.name}"
    else
      flash[:error] = @user.errors.full_messages
      render :login_form
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
