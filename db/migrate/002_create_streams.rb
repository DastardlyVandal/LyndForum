class CreateStreams < ActiveRecord::Migration[5.0]
  def change
    create_table :streams do |t|
      t.string :title
      t.integer :user_id
      t.integer :board_id
      t.timestamps
    end
  end
end
