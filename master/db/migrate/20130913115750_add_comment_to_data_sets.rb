class AddCommentToDataSets < ActiveRecord::Migration[4.2]
  def change
    add_column :data_sets, :comment, :string
  end
end
