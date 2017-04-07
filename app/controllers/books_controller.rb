class BooksController < ApplicationController
  before_action :load_book, only: [:show]

  def index
    if params[:search]
      @books = Book.search_book_name(params[:search])
        .paginate page: params[:page], per_page: Settings.number_per_page_user
    else
      @books = Book.all.paginate page: params[:page],
        per_page: Settings.number_per_page_user
    end
  end

  def new
  end

  def create
  end

  def update
  end

  def show
    if @book.commments.blank?
      @rating = 0
    else
      @rating = @book.commments.average(:rate).round(2)
    end
  end

  private

  def load_book
    @book = Book.find_by id: params[:id]
    return if @book
    flash[:alert] = t "users.nil_user"
    redirect_to root_path
  end
end
