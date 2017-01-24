class CreateStreams < ActiveRecord::Migration[5.0]
  def change
    create_table :streams do |t|
      add_column :streams, :title, :string
      add_column :streams, :user_id, :integer
      add_column :streams, :board_id, :int
      t.timestamps
    end
  end
end
