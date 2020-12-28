class CreateFollows < ActiveRecord::Migration[6.0]
  def change
    create_table :follows do |t|
      t.integer :foller_id
      t.integer :followee_id

      t.timestamps
    end
  end
end
