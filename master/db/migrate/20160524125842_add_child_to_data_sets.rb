class AddChildToDataSets < ActiveRecord::Migration[4.2]
  def change
    add_column :data_sets, :child, :boolean, default: false, null: false
  end
end
