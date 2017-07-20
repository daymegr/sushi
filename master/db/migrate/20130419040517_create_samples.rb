class CreateSamples < ActiveRecord::Migration[4.2]
  def change
    create_table :samples do |t|
      t.text :key_value
      t.integer :data_set_id

      t.timestamps
    end
  end
end
