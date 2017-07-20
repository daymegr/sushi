class AddBFabricIdToDataSets < ActiveRecord::Migration[4.2]
  def change
    add_column :data_sets, :bfabric_id, :integer
  end
end
