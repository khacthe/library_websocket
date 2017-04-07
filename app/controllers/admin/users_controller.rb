class Admin::UsersController < Admin::BaseController

  before_action :verify_admin
  before_action :load_user, except: [:index, :new, :create]

  def index
    if params[:search]
      @users = User.all_users(params[:search]).paginate(page: params[:page],
        per_page: Settings.number_per_page)
    else
      @users = User.all.paginate(page: params[:page],
        per_page: Settings.number_per_page)
    end
    respond_to do |format|
      format.html
      format.xls {
        send_data User.all.to_xls
      }
    end
  end

  def show
  end

  def edit
  end

  def update
    if @user.update_attributes user_params
      flash[:success] = t "users.update_success"
      redirect_to admin_users_path
    else
      flash[:alert] = t "users.update_error"
      render :edit
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:info] = t "users.create_success"
      redirect_to admin_users_path
    else
      render :new
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t "users.delete_success"
    else
      flash[:alert] = t "users.delete_error"
    end
    redirect_to admin_users_path
  end

  private

  def user_params
    params.require(:user).permit :fullname, :email, :password, :address,
      :phone, :password_confirmation, :is_admin, :avatar
  end

  def load_user
    @user = User.find_by id: params[:id]
    return if @user
    flash[:alert] = t "users.nil_user"
    redirect_to root_path
  end
end
