class UsersController < ApplicationController
  before_action :set_user, only: %i[update show edit destroy]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to @user
    else
      render :new, status: :unprocessable_content
    end
  end

  def show
  end

  def edit
  end

  def update
    if @user.nil?
      redirect_to root_path
    else
      redirect_to @user
    end
  end

  def destroy
    if @user.nil?
      redirect_to users_path
    else
      @user.delete

      redirect_to users_path, status: :see_other
    end
  end

  private

  def user_params
    params.expect(user: [ :username, :email, :password, :password_confirmation ])
  end

  def set_user
    @user = User.find_by(id: params[:id])
  end
end
