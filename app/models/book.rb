class Book < ApplicationRecord
  belongs_to :user
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  validates :title , presence: true
  validates :body , presence: true
  validates :body ,length: { maximum:200 }
  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  class << self
    def search(search,word)
      if search == "forward_match"
        @books = Book.where("title LIKE?","#{word}%")
      elsif search == "backward_match"
        @books = Book.where("title LIKE?","%#{word}")
      elsif search == "perfect_match"
        @books = Book.where(title: word)
      elsif search == "partial_match"
        @books = Book.where("title LIKE?","%#{word}%")
      else
        @books = Book.all
      end
    end
  end
end
