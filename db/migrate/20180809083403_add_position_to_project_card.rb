class AddPositionToProjectCard < ActiveRecord::Migration[5.2]
  def change
    add_column :project_cards, :position, :integer
  end
end
