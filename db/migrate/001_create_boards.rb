class CreateBoards < ActiveRecord::Migration[5.0]
  def change
    create_table :boards do |t|
      t.string :name
      t.boolean :locked, default: false
      t.timestamps
    end
  end
end
