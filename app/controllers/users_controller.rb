class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
    @currentuser = User.find(current_user.id)
  end

  def edit
    @user = User.find(params[:id])
    @books = @user.books
    if @user == current_user
      render "edit"
    else
      redirect_to user_path(current_user.id)
    end
  end
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
    redirect_to user_path(@user.id),notice:'You have updated book successfully.'
    else
      render 'edit'
    end
  end

  def index
    @user = User.find(current_user.id)
    @book = Book.new
    @users = User.all
  end

  private
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
  private
  def correct_user
     user = User.find(params[:id])
     if current_user != user
       redirect_to user_path(current_user.id)
     end
  end
end
