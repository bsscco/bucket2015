class AddCoverUrl0ToAdvice < ActiveRecord::Migration[5.2]
  def change
    add_column :advices, :cover_url0, :string
  end
end
