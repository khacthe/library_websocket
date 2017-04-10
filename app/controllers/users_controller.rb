class UsersController < ApplicationController

  before_action :load_user, except: [:index, :new, :create]
  before_action :logged_in_user, only: [:following, :followers]

  def index
    if params[:search]
      @users = User.all_users(params[:search]).paginate page: params[:page],
        per_page: Settings.number_per_page_user
    else
      @users = User.all.paginate page: params[:page],
        per_page: Settings.number_per_page_user
    end
  end

  def show
  end

  def new
    @user = User.new
  end

  def edit
  end

  def update
    if @user.update_attributes user_params
      flash[:success] = t "users.update_success"
      redirect_to @user
    else
      flash[:alert] = t "users.update_error"
      render :edit
    end
  end

  def create
    @user = User.new user_params
    if @user.save
      @user.send_activation_email
      flash[:success] = t "sessions.please_check_email"
      redirect_to login_path
    else
      flash[:alert] = t "sessions.signup_error"
      render :new
    end
  end

  def following
    @title = "Following"
    @user  = User.find_by id: params[:id]
    @users = @user.following.paginate page: params[:page]
    render "show_follow"
  end

  def followers
    @title = "Followers"
    @user  = User.find_by id: params[:id]
    @users = @user.followers.paginate page: params[:page]
    render "show_follow"
  end

  def borrowing_book
    @title = "Borrowing"
    @user  = User.find_by id: params[:id]
    @brorrows = @user.borrow_books.paginate page: params[:page]
    @books = @user.borrowing_book.paginate page: params[:page]
    render "show_borrow"
  end

  private

  def user_params
    params.require(:user).permit :fullname, :email, :password, :address,
      :phone, :password_confirmation, :avatar
  end

  def load_user
    @user = User.find_by id: params[:id]
    return if current_user? @user
    flash[:alert] = "login or action error"
    redirect_to root_path
  end
end
