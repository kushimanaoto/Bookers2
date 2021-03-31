class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: [:edit, :update]

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
    redirect_to book_path(@book.id),notice:'You have created book successfully.'
    else
      @user = current_user
      @books = Book.all
      render 'index'
    end
  end

  def index
    @user = current_user
    @book = Book.new
    @books = Book.all

  end

  def show
    @books = Book.all
    @showbook = Book.find(params[:id])
    @book = Book.new
    @user = @showbook.user
    @book_comment = BookComment.new
    @book_comments = @showbook.book_comments
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path ,notice:"Book was successfully destroyed."
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
    redirect_to book_path(@book.id),notice:'Book was successfully updated.'
    else
    render 'edit'
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  private
  def book_params
    params.require(:book).permit(:title,:body)
  end

  private
    def correct_user
      book = Book.find(params[:id])
      if current_user.id != book.user_id
      redirect_to books_path
      end
    end
end
