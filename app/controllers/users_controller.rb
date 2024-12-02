class UsersController < ApplicationController
  before_action :set_user, only: %i[update show edit destroy]
  before_action :authenticate!, only: %i[edit update destroy index show]
  before_action :validate_user, only: %i[update destroy]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = "User created successfully"
      redirect_to auth_login_path
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
      if @user.update(user_params)
        flash[:success] = "User updated successfully"
        redirect_to @user
      else
        render :edit, status: :unprocessable_content
      end
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

  def validate_user
    if @user != current_user
      flash[:error] = "You are not authorized to perform this action."
      redirect_to users_path
    end
  end
end
