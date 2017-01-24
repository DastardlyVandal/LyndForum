class CreateBoards < ActiveRecord::Migration[5.0]
  def change
    create_table :boards do |t|
      add_column :boards, :name, :string
      t.timestamps
    end
  end
end
