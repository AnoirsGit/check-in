class CreateProjectTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :project_tasks do |t|
      t.references :user, null: false, foreign_key: true
      t.references :project, null: false, foreign_key: true
      t.references :task, null: false, foreign_key: true

      t.timestamps
    end
  end
end
