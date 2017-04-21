class AuthorsController < ApplicationController

  before_action :load_author, only: [:show]

  def index
    if params[:search]
      @authors = Author.search_author_name(params[:search]).paginate page: params[:page],
        per_page: Settings.number_per_page_user
    else
      @authors = Author.all.paginate page: params[:page],
        per_page: Settings.number_per_page_user
    end
  end

  def show
  end

  private

  def load_author
    @author = Author.find_by slug: params[:id]
    return if @author
    flash[:alert] = t "users.nil_user"
    redirect_to root_path
  end
end
