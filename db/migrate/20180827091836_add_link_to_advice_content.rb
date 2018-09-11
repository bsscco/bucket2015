class AddLinkToAdviceContent < ActiveRecord::Migration[5.2]
  def change
    add_column :advice_contents, :link, :string
  end
end
