class AddFavouritesToUserBooks < ActiveRecord::Migration[6.0]
  def change
    add_column :user_books, :favourites, :boolean, default: false
  end
end
