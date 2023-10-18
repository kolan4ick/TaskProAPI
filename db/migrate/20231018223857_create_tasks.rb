class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do | t |
      t.string :title
      t.string :description
      t.datetime :deadline
      t.references :user, null: false, foreign_key: true
      t.references :assignee, null: false, foreign_key: { to_table: :users }
      t.integer :priority_level
      t.integer :status
      t.datetime :completed_at

      t.timestamps
    end
  end
end
