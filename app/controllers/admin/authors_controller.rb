class Admin::AuthorsController < Admin::BaseController

  before_action :verify_admin
  before_action :load_author, except: [:index, :new, :create]

  def index
    if params[:search]
      @author = Author.search_author_name(params[:search])
        .paginate page: params[:page], per_page: Settings.number_per_page
    else
      @author = Author.all.paginate page: params[:page],
        per_page: Settings.number_per_page
    end
    respond_to do |format|
      format.html
      format.xls {
        send_data @author.to_xls
      }
    end
  end

  def show
  end

  def edit
  end

  def update
    if @author.update_attributes author_params
      flash[:success] = t "users.update_success"
      redirect_to admin_authors_path
    else
      flash[:alert] = t "users.update_error"
      render :edit
    end
  end

  def new
    @author = Author.new
  end

  def create
    @author = Author.new author_params
    if @author.save
      flash[:info] = t "users.create_success"
      redirect_to admin_authors_path
    else
      render :new
    end
  end

  def destroy
    if @author.destroy
      flash[:success] = t "users.delete_success"
    else
      flash[:alert] = t "users.delete_error"
    end
    redirect_to admin_authors_path
  end

  private

  def author_params
    params.require(:author).permit :name, :description, :authorimage
  end

  def load_author
    @author = Author.find_by id: params[:id]
    return if @author
    flash[:alert] = t "users.nil_user"
    redirect_to root_path
  end
end
