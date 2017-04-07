class Admin::BooksController < Admin::BaseController

  before_action :find_book, except: [:index, :new, :create]

  def index
    if params[:search]
      @books = Book.search_book_name(params[:search]).paginate page: params[:page],
        per_page: Settings.number_per_page
    else
      @books = Book.all.paginate page: params[:page],
        per_page: Settings.number_per_page
    end
    respond_to do |format|
      format.html
      format.xls {
        send_data @books.to_xls
      }
    end
  end

  def show
  end

  def edit
  end

  def update
    if @book.update_attributes book_params
      flash[:success] = t "users.update_success"
      redirect_to admin_books_path
    else
      flash[:alert] = t "users.update_error"
      render :edit
    end
  end

  def new
    @book = Book.new
    @book.build_author
    @book.build_publisher
  end

  def create
    @book = Book.new book_params
    @author_param = Author.find_by name:
      params[:book][:author_attributes][:name]
    @publisher_param = Publisher.find_by name:
      params[:book][:publisher_attributes][:name]
    if @author_param
      @book[:author_id] = @author_param.id
    end
    if @publisher_param
      @book[:publisher_id] = @publisher_param.id
    end
    if @book.save
      flash[:info] = t "users.create_success"
       redirect_to admin_books_path
    else
      render :new
    end
  end

  def destroy
    if @book.destroy
      flash[:success] = t "users.delete_success"
    else
      flash[:alert] = t "users.delete_error"
    end
    redirect_to admin_books_path
  end

  private

  def book_params
    params.require(:book).permit(:name, :description,
      :author_id, :number_book, :pages_number, :category_id, :user_id, :image,
      author_attributes: [:id, :name], publisher_attributes: [:id, :name])
  end

  def find_book
    @book = Book.find_by id: params[:id]
    unless @book
      flash[:alert] = t "users.nil_user"
      redirect_to admin_books_path
    end
  end
end
