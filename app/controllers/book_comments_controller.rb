class BookCommentsController < ApplicationController
  before_action  :correct_user,   only: [:destroy]
  def create
    @book = Book.find(params[:book_id])
    @book_comment = @book.book_comments.new(book_comment_params)
    @book_comment.user_id = current_user.id
    @user_book = Book.find(params[:book_id])
    @user_book_comments = @user_book.book_comments
    @book_comment.save
  end
  def destroy
    @user_book = Book.find(params[:book_id])
    @user_book_comments = @user_book.book_comments
    @book_comment = BookComment.find(params[:id])
    @book_comment.destroy
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
