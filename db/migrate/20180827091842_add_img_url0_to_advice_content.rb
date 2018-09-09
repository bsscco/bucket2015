class AddImgUrl0ToAdviceContent < ActiveRecord::Migration[5.2]
  def change
    add_column :advice_contents, :img_url0, :string
  end
end
