class FollowBooksController < ApplicationController
  before_action :logged_in_user

  def index
    @follow_books = FollowBook.all
  end

  def create
    @book = Book.find params[:book_id]
    current_user.follow_book @book
    respond_to do |format|
      format.html { redirect_to @book }
      format.js
    end
  end

  def destroy
    @book = FollowBook.find(params[:id]).book
    current_user.unfollow_book @book
    respond_to do |format|
      format.html { redirect_to @book }
      format.js
    end
  end
end
