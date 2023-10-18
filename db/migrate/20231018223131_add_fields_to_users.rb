class AddFieldsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :first_name, :string, null: false, default: ''
    add_column :users, :last_name, :string, null: false, default: ''
    add_column :users, :phone, :string, null: false, default: ''
    # add_column :users, :username,   :string, null: false, default: ''
    # add_column :users, :role,       :string, null: false, default: 'user'
    # add_column :users, :active,     :boolean, null: false, default: true
    # add_column :users, :deleted,    :boolean, null: false, default: false
    # add_column :users, :deleted_at, :datetime
    # add_index :users, :username, unique: true
  end
end
