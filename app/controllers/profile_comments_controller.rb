class ProfileCommentsController < ApplicationController
  def create
    book = Book.find(params[:profile_image_id])
    comment = current_user.book_comments.new(book_comment_params)
    comment.profile_image_id = profile_image.id
    comment.save
    redirect_to book_path(book)
  end

  def destroy
  end

  private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end
end
