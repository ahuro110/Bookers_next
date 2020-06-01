class BookCommentsController < ApplicationController
  before_action  :correct_user,   only: [:destroy]
  def create
    @book_comment = current_user.book_comments.new(book_comment_params)
    @book_comment.book_id = Book.find(params[:book_id]).id
    @book_comment.save
    redirect_to book_path(params[:book_id])

  end
  def destroy
    @book_comment = BookComment.find(params[:id])
    @book_comment.destroy
    redirect_to book_path(params[:book_id])
  end
  private
  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end

  def correct_user
    @user = BookComment.find(params[:id]).user
    redirect_to books_path unless current_user?(@user)
  end

  def current_user?(user)
    user == current_user
  end


end
