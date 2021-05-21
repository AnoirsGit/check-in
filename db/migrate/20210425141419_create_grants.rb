class CreateGrants < ActiveRecord::Migration[6.1]
  def change
    create_table :grants do |t|
      t.integer :owner
      t.integer :target

      t.timestamps
    end

    add_index :grants, [:owner, :target], unique: true
  end
end
