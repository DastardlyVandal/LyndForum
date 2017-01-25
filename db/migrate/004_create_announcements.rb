class CreateAnnouncements < ActiveRecord::Migration[5.0]
  def change
    create_table :announcements do |t|
      t.string :title
      t.string :content
      t.integer :user_id
      t.timestamps
    end
  end
end
