class AddImgToAdviceContent < ActiveRecord::Migration[5.2]
  def change
    add_column :advice_contents, :img, :string
  end
end
