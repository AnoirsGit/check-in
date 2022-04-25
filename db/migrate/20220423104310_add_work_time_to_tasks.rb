class AddWorkTimeToTasks < ActiveRecord::Migration[6.1]
  def change
    add_reference :working_times, :task, foreign_key: true
    # remove_column :working_times, :category_id, 
    add_column :tasks, :time_to_complete, :bigint, default: 0
  end
end
