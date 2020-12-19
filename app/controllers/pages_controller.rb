class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
  end

  def dashboard
    user_books = current_user.books
    @total_books = user_books.count
    @read_books = user_books.where(:completed == true).count
    @unread_books = user_books.where(:completed == false).count
    # Arranging and counting author occurences within the users books
    authors = []
    user_books.each { |book| authors << book.author}
    authors_count = Hash.new(0)
    authors.each { |author| authors_count[author] += 1 }

    @most_popular_authors = authors_count.sort_by { |k, v| v }.reverse.first(3)
  end
end
