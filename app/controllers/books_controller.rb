require 'json'
require 'open-uri'

class BooksController < ApplicationController
  def index
  end

  def show
  end

  def new
    q = params[:q]
    url = "https://www.googleapis.com/books/v1/volumes?q=#{q}"

    if params[:q]
      json = open(url).read
      data = JSON.parse(json)

      book = data['items'][0]
      info = book['volumeInfo']
      @title = info['title']
      @subtitle = info['subtitle']
      @author = info['authors'][0]
      @description = info['description']
      @pages = info['pageCount']
      @categories = info['categories']
      @smallThumbUrl = info['imageLinks']['smallThumbnail']
      @thumbUrl = info['imageLinks']['thumbnail']
    end
  end

  def create
    @book = Book.new(book_params)
    @book.title = params[:book][:title]
    @book.subtitle = params[:book][:subtitle]
    @book.author = params[:book][:author]
    @book.description = params[:book][:description]
    @book.pages = params[:book][:pages]
    @book.categories = params[:book][:categories]
    @book.smallThumbnailUrl = params[:book][:smallThumbUrl]
    @book.thumbnailUrl = params[:book][:thumbnailUrl]
    if @book.save!
      @user_book = UserBook.new(book_id: @book.id, user_id: current_user.id)
      @user_book.save!
      redirect_to dashboard_path
      flash[:notice] = 'Book Successfully Saved!'
    else
      flash[:alert] = 'Oops, something went wrong!'
      render :new
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def user_book_params
    user_id = current_user.id
    book_id = @book.id

    # params.require(:user_book).permit(:book_id, :user_id)
  end

  def book_params
    params.require(:book).permit(:title, :author, :subtitle, :description, :pages, :completed, :smallThumbnailUrl, :thumbnailUrl, categories: [])
  end
end
