class CreateProjectCards < ActiveRecord::Migration[5.2]
  def change
    create_table :project_cards do |t|
      t.belongs_to :project, index: true
      t.belongs_to :card, index: true

      t.string :content

      t.timestamps
    end
  end
end
