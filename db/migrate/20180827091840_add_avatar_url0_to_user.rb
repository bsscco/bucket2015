class AddAvatarUrl0ToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :avatar_url0, :string
  end
end
