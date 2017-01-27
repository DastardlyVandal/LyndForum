class CreateStreams < ActiveRecord::Migration[5.0]
  def change
    create_table :streams do |t|
      t.string :title
      t.integer :user_id
      t.integer :board_id
      t.boolean :is_stickied, default: false
      t.boolean :locked, default: false
      t.timestamps
    end
  end
end
