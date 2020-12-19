class RemoveCompletedFromBooks < ActiveRecord::Migration[6.0]
  def change
    remove_column :books, :completed, :boolean
  end
end
