class Book < ApplicationRecord
  has_many :users, through: :user_books
end
