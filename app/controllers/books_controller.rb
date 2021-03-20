class BooksController < ApplicationController
  before_action :authenticate_user!, only: [:show]
  def new
    @user = User.find(current_user.id)
    @book = Book.new
    @books = Book.all
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
    redirect_to book_path(@book.id),notice:'You have created book successfully.'
    else
      @user = User.find(current_user.id)
      @books = Book.all
      render 'new'
    end
  end

  def index
    @user = User.find(current_user.id)
    @book = Book.new
    @books = Book.all
  end

  def show
    @showbook = Book.find(params[:id])
    @book = Book.new
    @books = Book.all
    @user = User.find(current_user.id)
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to book_path ,notice:"Book was successfully destroyed."
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
    redirect_to book_path(@book.id),notice:'Book was successfully updated.'
    else
    render action: :edit
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  private

  def book_params
    params.require(:book).permit(:title,:body)
  end
end
