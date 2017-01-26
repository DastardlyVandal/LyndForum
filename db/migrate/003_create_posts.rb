class CreatePosts < ActiveRecord::Migration[5.0]
  def change
    create_table :posts do |t|
      t.integer :board_id
      t.integer :stream_id
      t.integer :user_id
      t.string :content
      t.boolean :reported, default: false
      t.string :report_reason, default: ''
      t.timestamps
    end
  end
end
