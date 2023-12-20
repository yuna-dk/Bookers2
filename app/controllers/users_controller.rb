class UsersController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "Welcome! You have signed up successfully."
      redirect_to user_path(@user.id)
    else
      flash.now[:alert] = "An error has occurred.Please try again later"
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def index
    @users = User.all
    @user = current_user
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params_update)
      flash[:notice] = "You have updated user successfully."
    redirect_to user_path(@user.id)
    else
      lash.now[:notice] = "An error has occurred.Please try again later."
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :email)
  end

  def user_params_update
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to books_path
    end
  end
    
end
