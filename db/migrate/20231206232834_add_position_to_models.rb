class AddPositionToModels < ActiveRecord::Migration[7.0]
  def change
    add_column :boards, :position, :integer, default: 1
    add_column :rosters, :position, :integer, default: 1
    add_column :tasks, :position, :integer, default: 1
  end
end
