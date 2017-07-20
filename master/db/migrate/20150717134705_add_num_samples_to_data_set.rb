class AddNumSamplesToDataSet < ActiveRecord::Migration[4.2]
  def change
    add_column :data_sets, :num_samples, :integer
  end
end
