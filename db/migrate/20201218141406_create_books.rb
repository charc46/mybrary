class CreateBooks < ActiveRecord::Migration[6.0]
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.string :description
      t.integer :pages
      t.string :categories
      t.boolean :completed, default: :false

      t.timestamps
    end
  end
end
