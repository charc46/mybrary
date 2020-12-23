class UserBooksController < ApplicationController
  def create
  end

  def update
    @user_book = UserBook.find(params[:id])
    book = Book.find(@user_book.book_id)
    @user_book.update(completed: params[:completed])
    if @user_book.save
      redirect_to book_path(book.id)
      flash[:notice] = "Book sucessfully updated"
    else
      render :show
      flash[:alert] = "Something went wrong"
    end
  end

  def destroy
    user_book = UserBook.where("book_id": UserBook.find(params[:id]).book_id, "user_id": current_user.id)
    @user_book = user_book[0]
    @user_book.destroy
    redirect_to books_path
    flash[:notice] = "Book deleted"
  end

  private

  def book_params
    params.require(:user_book).permit(:completed)
  end
end
