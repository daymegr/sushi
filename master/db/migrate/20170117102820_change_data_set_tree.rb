class ChangeDataSetTree < ActiveRecord::Migration[4.2]
  def change
    change_column :projects, :data_set_tree, :text, :limit => 16777215
  end
end
