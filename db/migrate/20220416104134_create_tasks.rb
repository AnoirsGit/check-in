class CreateTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :tasks do |t|
      t.string :title
      t.string :description
      t.date :deadline
      t.integer :status

      t.timestamps
    end
  end
end
