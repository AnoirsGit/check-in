class CreateProjects < ActiveRecord::Migration[6.1]
  def change
    create_table :projects do |t|
      t.string :title
      t.string :description
      t.date :deadline
      t.integer :status
      t.string :color

      t.timestamps
    end
  end
end
