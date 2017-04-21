class BorrowBooksController < ApplicationController
  before_action :check_currentuser, only: [:create, :destroy]

  def create
    @borrowbook = BorrowBook.new borrow_params
    @borrowbook[:user_id] = current_user.id
    @borrowbook[:book_id] = params[:book_id]
    @admin = User.find_by is_admin: true
    if @borrowbook.save
      Notification.create( user_id: @admin.id, notification_type: "borrowbook", notification: "#{current_user.fullname} borrow book #{@borrowbook.book.name}", notification_link: "#{edit_admin_borrow_book_path(@borrowbook)}" )
      respond_to do |format|
      format.html {redirect_to @book}
      format.js
    end
      flash[:info] = t "users.create_success"
      redirect_to @borrowbook.book
    else
      redirect_to @book
    end

  end

  def destroy
  end

  private

  def borrow_params
    params.require(:borrow_book).permit :book_id, :date_from, :date_to, :status
  end

  def check_currentuser
    unless logged_in?
      flash[:alert] = "Please login !"
      redirect_to login_path
    end
  end
end
