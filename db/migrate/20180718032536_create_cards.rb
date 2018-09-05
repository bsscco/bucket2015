class CreateCards < ActiveRecord::Migration[5.2]
  def change
    create_table :cards do |t|
      t.belongs_to :user
      t.string :content
      t.string :img

      t.timestamps
    end
  end
end
