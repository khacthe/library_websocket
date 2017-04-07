class LikeActivesController < ApplicationController
  before_action :logged_in_user

  def create
    @book = Book.find params[:book_id]
    current_user.like_book @book
    respond_to do |format|
      format.html { redirect_to @book }
      format.js
    end
  end

  def destroy
    @book = LikeActive.find(params[:id]).book
    current_user.unlike_book @book
    respond_to do |format|
      format.html { redirect_to @book }
      format.js
    end
  end
end
