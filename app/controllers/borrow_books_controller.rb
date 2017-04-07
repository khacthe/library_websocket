class BorrowBooksController < ApplicationController
  before_action :check_currentuser, only: [:create, :destroy]

  def create
    @borrowbook = BorrowBook.new borrow_params
    @borrowbook[:user_id] = current_user.id
    @borrowbook[:book_id] = params[:book_id]
    if @borrowbook.save
      respond_to do |format|
      format.html { redirect_to @book }
      format.js
    end
      flash[:info] = t "users.create_success"
      # redirect_to @borrowbook.book
    else
      redirect_to @book
    end

  end

  def destroy
  end

  private

  def borrow_params
    params.require(:borrow_book).permit :book_id, :date_from, :date_to
  end

  def check_currentuser
    unless logged_in?
      flash[:alert] = "Please login !"
      redirect_to login_path
    end
  end
end
