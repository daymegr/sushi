class AddCompletedSamplesToDataSet < ActiveRecord::Migration[4.2]
  def change
    add_column :data_sets, :completed_samples, :integer
  end
end
