class UserBooksController < ApplicationController
  def create
  end

  def update
    book = current_user.books.find(params[:id])
    @user_book = UserBook.find("book_id": book.id)
    @user_book.update(book_params)
    redirect_to book_path(book.id)
  end

  def destroy
    @book = UserBook.find(params[:id])
    if @book.delete
      redirect_to books_path
      flash[:notice] = "Book deleted"
    else
      render :show
      flash[:notice] = "Oops, something went wrong"
  end

  private

  def book_params
    params.require(:user_book).permit(:completed)
  end
end
