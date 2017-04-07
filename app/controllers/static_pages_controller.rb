class StaticPagesController < ApplicationController
  def home
    @books = Book.all.paginate page: params[:page],
        per_page: Settings.number_per_page_user
    @categories = Category.all
  end

  def help
  end

  def about
  end
end
