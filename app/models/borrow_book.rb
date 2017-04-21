class BorrowBook < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates :date_from, presence:true
  validates :date_to, presence:true
  
  default_scope {order(created_at: :desc)}
  scope :search_brorrow_by_user, -> search {where("id LIKE ?", "%#{search}%")}
  scope :show_borrowbook, ->{where status: "borrowed"}
  scope :get_borrow_deadline, ->{where("created_at < ?", DateTime.now)}

  def self.send_emailborrow_deadline
    @borrowbooks = BorrowBook.get_borrow_deadline.show_borrowbook
    @borrowbooks.each do |borrow|
      UserMailer.borrow_book_deadline(borrow.user).deliver_now
    end
  end
end
