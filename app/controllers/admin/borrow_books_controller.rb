class Admin::BorrowBooksController < Admin::BaseController

  before_action :find_borrow_book, except: [:index, :new, :create]

  def index
    if params[:search]
      @borrow_books = BorrowBook.search_brorrow_by_user(params[:search]).paginate(page: params[:page],
        per_page: Settings.number_per_page)
    else
      @borrow_books = BorrowBook.all.paginate(page: params[:page],
        per_page: Settings.number_per_page)
    end
    respond_to do |format|
      format.html
      format.xls {
        send_data @borrowbooks.to_xls
      }
    end
  end

  def edit
  end

  def update
    if @borrow_book.update_attributes borrow_book_params
      @borrow_book.user.send_borrow_email
      Notification.create( user_id: @borrow_book.user.id, notification_type: "borrow", notification: "Admin library #{borrow_book_params[status]} your borrow", notification_link: "#{borrowing_book_user_path(@borrow_book.user)}" )
      flash[:success] = "Update borrow book success !"
      redirect_to admin_borrow_books_path
    else
      flash[:alert] = "Update borrow book error !"
      render :edit
    end
  end

  def destroy
     if @borrow_book.destroy
      flash[:success] =  "Borrow book deleted !"
    else
      flash[:alert] = "Delete borrow book error !"
    end
    redirect_to admin_borrow_books_path
  end

  private

  def borrow_book_params
    params.require(:borrow_book).permit :status
  end

  def find_borrow_book
    @borrow_book = BorrowBook.find_by_id params[:id]
  end
end
