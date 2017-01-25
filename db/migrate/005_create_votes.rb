class CreateVotes < ActiveRecord::Migration[5.0]
  def change
    create_table :votes do |t|
      t.integer :user_id
      t.integer :post_id
      t.integer :poster_id
      t.integer :vote   # 1 for thumbup, 0 for no vote, and -1 for thumbdown
      t.timestamps
    end
  end
end
