class AddPointsToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :thumbup, :integer
    add_column :users, :thumbdown, :integer
  end
end
