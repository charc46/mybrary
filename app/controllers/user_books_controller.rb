class UserBooksController < ApplicationController
  def index
    @user = User.find(params[:id])
    @books = @user.books
    if params[:q]
      sql_query = "title ILIKE :q OR author ILIKE :q OR categories ILIKE :q"
      @books = @user.books.where(sql_query, q: "%#{params[:q]}%").paginate(page: params[:page], per_page: 10)
    else
      @books = @user.books.paginate(page: params[:page], per_page: 10)
    end
  end

  def show
    @book = Book.find(params[:id])
  end

  def create
    @book = Book.find(params[:id])
    @user_book = UserBook.new(user_id: current_user.id, book_id: @book.id)
    if @user_book.save!
      redirect_to user_book_path(@user_book.id)
      flash[:notice] = "Book saved"
    else
      render :show
      flash[:alert] = "Oops, something went wrong"
    end
  end

  def add_to_favourite
    @user_book = UserBook.find(params[:id])
    book = Book.find(@user_book.book_id)
    @user_book.update(favourites: params[:favourites])
    if @user_book.save
      redirect_to book_path(book.id)
      @user_book.favourites == true ? flash[:notice] = "Added to favourites!" : flash[:notice] = "Removed from favourites!"
    else
      render :show
      flash[:alert] = "Something went wrong"
    end
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
