class CreateTaskProjectUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :task_project_users do |t|
      t.references :user, null: false, foreign_key: true
      t.references :project, null: false, foreign_key: true
      t.references :task, null: false, foreign_key: true

      t.timestamps
    end
  end
end
