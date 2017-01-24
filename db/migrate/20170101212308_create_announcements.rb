class CreateAnnouncements < ActiveRecord::Migration[5.0]
  def change
    create_table :announcements do |t|
      add_column :announcements, :title, :string
      add_column :announcements, :content, :string
      t.timestamps
    end
  end
end
