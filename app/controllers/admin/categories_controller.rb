class Admin::CategoriesController < Admin::BaseController

  before_action :verify_admin
  before_action :load_category, except: [:index, :new, :create]

  def index
    if params[:search]
      @categories = Category.search_category_name(params[:search]).paginate page: params[:page],
        per_page: Settings.number_per_page
    else
      @categories = Category.all.paginate page: params[:page],
        per_page: Settings.number_per_page
    end
    respond_to do |format|
      format.html
      format.xls {
        send_data @categories.to_xls
      }
    end
  end

  def show
  end

  def edit
  end

  def update
    if @category.update_attributes category_params
      flash[:success] = t "users.update_success"
      redirect_to admin_categories_path
    else
      flash[:alert] = t "users.update_error"
      render :edit
    end
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new category_params
    if @category.save
      flash[:info] = t "users.create_success"
      redirect_to admin_categories_path
    else
      render :new
    end
  end

  def destroy
    if @category.destroy
      flash[:success] = t "users.delete_success"
    else
      flash[:alert] = t "users.delete_error"
    end
    redirect_to admin_categories_path
  end

  private

  def category_params
    params.require(:category).permit :name
  end

  def load_category
    @category = Category.find_by id: params[:id]
    return if @category
    flash[:alert] = t "users.nil_user"
    redirect_to root_path
  end
end
