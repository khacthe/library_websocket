class Admin::PublishersController < Admin::BaseController

  before_action :verify_admin
  before_action :load_publisher, except: [:index, :new, :create]

  def index
    if params[:search]
      @publishers = Publisher.search_publisher_name(params[:search])
        .paginate page: params[:page], per_page: Settings.number_per_page
    else
      @publishers = Publisher.all.paginate page: params[:page],
        per_page: Settings.number_per_page
    end
    respond_to do |format|
      format.html
      format.xls {
        send_data @publishers.to_xls
      }
    end
  end

  def show
  end

  def edit
  end

  def update
    if @publisher.update_attributes publisher_params
      flash[:success] = t "users.update_success"
      redirect_to admin_publishers_path
    else
      flash[:alert] = t "users.update_error"
      render :edit
    end
  end

  def new
    @publisher = Publisher.new
  end

  def create
    @publisher = Publisher.new publisher_params
    if @publisher.save
      flash[:info] = t "users.create_success"
      redirect_to admin_publishers_path
    else
      render :new
    end
  end

  def destroy
    if @publisher.destroy
      flash[:success] = t "users.delete_success"
    else
      flash[:alert] = t "users.delete_error"
    end
    redirect_to admin_publishers_path
  end

  private

  def publisher_params
    params.require(:publisher).permit :name
  end

  def load_publisher
    @publisher = Publisher.find_by id: params[:id]
    return if @publisher
    flash[:alert] = t "users.nil_user"
    redirect_to root_path
  end
end
