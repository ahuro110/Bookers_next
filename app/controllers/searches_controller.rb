class SearchesController < ApplicationController
  def index
    @range = params[:range]
    search = params[:search]
    @user = current_user
    @book = Book.new
    word = params[:word]
    if @range == '1'
      @users = User.search(search,word)
    elsif @range == '2'
      @books = Book.search(search,word)
    end
  end
end