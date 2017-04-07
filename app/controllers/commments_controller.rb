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
      redirect_to @book
    else
      render :new
    end
  end

  def destroy
    if @commment.destroy
      flash[:success] = "Deleted !"
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

  # def find_user_comment
  #   binding.pry
  #   unless (@commment.user_id == current_user.id)
  #     flash[:alert] = "don't find book"
  #     redirect_to @book
  #   end
  # end
end
