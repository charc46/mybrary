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
      user_books.each { |book| authors << book.author }
      authors_count = Hash.new(0)
      authors.each { |author| authors_count[author] += 1 }

      @most_popular_authors = authors_count.sort_by { |k, v| v }.reverse.first(3)

      # Arranging and counting genre occurences within the users books
      genres = []
      user_books.each { |book| genres << book.categories unless book.categories == "" }
      genre_count = Hash.new(0)
      genres.each { |genre| genre_count[genre] += 1 }

      @most_popular_genres = genre_count.sort_by { |k, v| v }.reverse.first(5)

      # Work out average pages
      count = []
      user_books.each { |book| count << book.pages unless book.pages.nil? }
      @average_pages = count.sum / count.length unless count.empty?
    end
  end

  def categories
    @categories = params[:categories]
    @books = current_user.books.where("categories": params[:categories])
  end

  def author
    @author = params[:author]
    @books = current_user.books.where("author": params[:author])
  end

  def favourites
    books = current_user.user_books.where('favourites': true)
    @books = books.map { |book| Book.find(book.book_id)}
  end

  def profile
    @user = User.find(params[:id])
    @books = @user.books

    authors = []
    @books.each { |book| authors << book.author }
    authors_count = Hash.new(0)
    authors.each { |author| authors_count[author] += 1 }

    @most_popular_authors = authors_count.sort_by { |k, v| v }.reverse.first(3)

    # Arranging and counting genre occurences within the users books
    genres = []
    @books.each { |book| genres << book.categories}
    genre_count = Hash.new(0)
    genres.each { |genre| genre_count[genre] += 1 }

    @most_popular_genres = genre_count.sort_by { |k, v| v }.reverse.first(5)
  end
end
