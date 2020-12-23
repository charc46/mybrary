class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
  end

  def dashboard
    user_books = current_user.books
    unless user_books.nil?
      @total_books = user_books.count
      @read_books = current_user.user_books.complete.count
      @unread_books = current_user.user_books.not_complete.count
      # Arranging and counting author occurences within the users books
      authors = []
      user_books.each { |book| authors << book.author}
      authors_count = Hash.new(0)
      authors.each { |author| authors_count[author] += 1 }

      @most_popular_authors = authors_count.sort_by { |k, v| v }.reverse.first(3)

      # Arranging and counting genre occurences within the users books
      genres = []
      user_books.each { |book| genres << book.categories}
      genre_count = Hash.new(0)
      genres.each { |genre| genre_count[genre] += 1 }

      @most_popular_genres = genre_count.sort_by { |k, v| v }.reverse.first(5)

      # Work out average pages
      count = []
      user_books.each { |book| count << book.pages }
      @average_pages = count.sum / count.length if count.length > 0
    end
  end

  def categories
    @books = current_user.books.where("categories": params[:categories])
  end

  def author
    @books = current_user.books.where("author": params[:author])
  end
end
