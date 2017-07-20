class CreateProjects < ActiveRecord::Migration[4.2]
  def change
    create_table :projects do |t|
      t.integer :number

      t.timestamps
    end
  end
end
