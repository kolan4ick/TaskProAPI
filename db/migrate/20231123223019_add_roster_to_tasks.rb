class AddRosterToTasks < ActiveRecord::Migration[7.0]
  def change
    add_reference :tasks, :roster, null: false, foreign_key: true
  end
end
