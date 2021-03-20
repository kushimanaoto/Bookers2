class UsersController < ApplicationController
  before_action :authenticate_user!
  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new

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
    @books = Book.all
  end
   private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
end
