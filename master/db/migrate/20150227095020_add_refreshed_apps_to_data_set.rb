class AddRefreshedAppsToDataSet < ActiveRecord::Migration[4.2]
  def change
    add_column :data_sets, :refreshed_apps, :boolean
  end
end
