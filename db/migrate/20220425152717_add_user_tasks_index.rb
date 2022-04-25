class AddUserTasksIndex < ActiveRecord::Migration[6.1]
  def change
    add_index :user_tasks, [:user_id, :task_id], unique: true
  end
end
