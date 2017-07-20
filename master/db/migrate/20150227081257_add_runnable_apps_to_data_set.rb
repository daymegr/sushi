class AddRunnableAppsToDataSet < ActiveRecord::Migration[4.2]
  def change
    add_column :data_sets, :runnable_apps, :text
  end
end
