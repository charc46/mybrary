class AddThumbnailsToBook < ActiveRecord::Migration[6.0]
  def change
    add_column :books, :smallThumbnailUrl, :string
    add_column :books, :thumbnailUrl, :string
  end
end
