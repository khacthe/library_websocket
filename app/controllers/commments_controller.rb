class CommmentsController < ApplicationController

  before_action :find_book
  before_action :find_commment, only: [:destroy]
  before_action :check_currentuser, only: [:create, :destroy]

  def index
  end

  def show
  end

  def edit
  end

  def update
  end

  def create
    @commment = Commment.new(commment_params)
    @commment.book_id = @book.id
    @commment.user_id = current_user.id
    if @commment.save
      create_notification @commment
      redirect_to @book
    else
      render :new
    end
  end

  def destroy
    if @commment.destroy
    else
      flash[:alert] = t "don't pemission deleted !"
    end
    redirect_to @book
  end

  private

  def commment_params
    params.require(:commment).permit(:rate, :description)
  end

  def find_book
    @book = Book.find_by id: params[:book_id]
    unless @book.present?
      flash[:alert] = "don't find book"
      redirect_to root_path
    end
  end

  def check_currentuser
    unless logged_in?
      flash[:alert] = "Please login !"
      redirect_to login_path
    end
  end

  def find_commment
    @commment = Commment.find params[:id]
  end

  def create_notification comment
    @follow_books = FollowBook.find_all_by_book comment.book_id
    @follow_books.each do |followbook|
      Notification.create( user_id: followbook.user_id, notification_type: "comment", notification: "#{current_user.fullname} comment in #{@book.name}", notification_link: "#{book_path(@book)}" )
    end
  end
end
