class CreateRosters < ActiveRecord::Migration[7.0]
  def change
    create_table :rosters do |t|
      t.references :board, null: false, foreign_key: true
      t.string :title

      t.timestamps
    end
  end
end
