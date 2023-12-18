class ChangeNotifications < ActiveRecord::Migration[7.0]
  def change
    rename_column :notifications, :content, :content_uk
    add_column :notifications, :content_en, :string
  end
end
