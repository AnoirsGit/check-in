class CreateWorkingTimes < ActiveRecord::Migration[6.1]
  def change
    create_table :working_times do |t|
      t.string :started_at
      t.string :ended_at
      t.string :bio
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
