class AddScriptPathToJobs < ActiveRecord::Migration[4.2]
  def change
    add_column :jobs, :script_path, :string
  end
end
