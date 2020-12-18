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

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
