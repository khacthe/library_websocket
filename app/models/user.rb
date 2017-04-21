class User < ApplicationRecord

  attr_accessor :activation_token, :reset_token
  before_save :downcase_email
  before_create :create_activation_digest

  has_many :books, dependent: :destroy
  has_many :like_actives, dependent: :destroy
  has_many :commments, dependent: :destroy
  has_many :borrow_books
  has_many :follow_books
  has_many :follow_authors
  has_many :active_followusers, class_name: "FollowUser",
    foreign_key: "follower_id", dependent: :destroy
  has_many :passive_followusers, class_name: "FollowUser",
    foreign_key: "followed_id", dependent: :destroy
  has_many :following, through: :active_followusers, source: :followed
  has_many :followers, through: :passive_followusers, source: :follower
  has_many :following_book, through: :follow_books, source: :book
  has_many :following_author, through: :follow_authors, source: :author
  has_many :liking_book, through: :like_actives, source: :book
  has_many :borrowing_book, through: :borrow_books, source: :book
  has_many :notifications, dependent: :destroy
  validates :fullname,  presence: true,
    length: {maximum: Settings.maximum_name_email}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
    length: {maximum: Settings.maximum_name_email},
    format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}

  mount_uploader :avatar, ImageUploader

  has_secure_password

  scope :all_users, -> search {where("fullname LIKE ?", "%#{search}%")}

  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def self.to_xls options = {}
    column_names = ["id", "fullname", "phone", "email"]
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |user|
        csv << user.attributes.values_at(*column_names)
      end
    end
  end

  class << self
    def digest string
      cost = ActiveModel::SecurePassword.min_cost ?
        BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
    end

    def create_reset_digest
      self.reset_token = User.new_token
      update_attribute(:reset_digest,  User.digest(reset_token))
      update_attribute(:reset_sent_at, Time.zone.now)
    end
  end

  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  def activate
    update_attribute(:activated, true)
    update_attribute(:activated_at, Time.zone.now)
  end

  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end

  # Follows a user.
  def follow other_user
    active_followusers.create followed_id: other_user.id
  end

  # Unfollows a user.
  def unfollow other_user
    following.delete other_user
  end

  # Returns true if the current user is following the other user.
  def following? other_user
    following.include? other_user
  end

  # Follows a book.
  def follow_book other_book
    follow_books.create book_id: other_book.id
  end

  def unfollow_book other_book
    following_book.delete other_book
  end

  def following_book? other_book
    following_book.include? other_book
  end

  # Follows a author.
  def follow_author other_author
    follow_authors.create author_id: other_author.id
  end

  def unfollow_author other_author
    following_author.delete other_author
  end

  def following_author? other_author
    following_author.include? other_author
  end

  # Like book.
  def like_book other_book
    like_actives.create book_id: other_book.id
  end

  def unlike_book other_book
    liking_book.delete other_book
  end

  def liking_book? other_book
    liking_book.include? other_book
  end

  def borrowing_book? other_book
    borrowing_book.include? other_book
  end

  def send_borrow_email
    UserMailer.borrow_book(self).deliver_now
  end

  private

  def downcase_email
    self.email = email.downcase
  end

  def create_activation_digest
    self.activation_token  = User.new_token
    self.activation_digest = User.digest activation_token
  end
end
