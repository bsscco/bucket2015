class CreateAdviceContents < ActiveRecord::Migration[5.2]
  def change
    create_table :advice_contents do |t|
      t.belongs_to :advice

      t.string :content_type
      t.integer :content_id
      t.string :content

      t.timestamps
    end
  end
end
