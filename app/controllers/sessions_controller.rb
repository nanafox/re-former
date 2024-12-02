class SessionsController < ApplicationController
  before_action :set_user, except: [ :new, :destroy ]

  def new
  end

  def create
    if @user.authenticate(user_credentials[:password])
      session[:user_id] = @user.id
      Rails.logger.debug "Sessions: #{session[:user_id]} created"
      flash[:success] = "User sign in successful"
      redirect_to user_path(@user)
    else
      flash.now[:error] = "Invalid credentials"
      render :new, status: :unauthorized
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "Logged out successfully."
    redirect_to auth_login_path
  end

  private

  def user_credentials
    params.expect(user: [ :username, :password ])
  end

  def set_user
    @user = User.find_by(username: user_credentials[:username])

    if @user.nil?
      flash.now[:error] = "Invalid credentials"
      render :new, status: :unauthorized
    end
  end
end
