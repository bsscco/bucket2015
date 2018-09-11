class AddCoverToAdvice < ActiveRecord::Migration[5.2]
  def change
    add_column :advices, :cover, :string
  end
end
