class AddPositionToAdviceContent < ActiveRecord::Migration[5.2]
  def change
    add_column :advice_contents, :position, :integer
  end
end
