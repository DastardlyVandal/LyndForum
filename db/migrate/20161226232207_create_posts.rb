class CreatePosts < ActiveRecord::Migration[5.0]
  def change
    create_table :posts do |t|
      add_column :posts, :stream_id, :integer
      add_column :posts, :user_id, :integer
      t.timestamps
    end
  end
end
