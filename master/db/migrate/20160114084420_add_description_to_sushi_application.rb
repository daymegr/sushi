class AddDescriptionToSushiApplication < ActiveRecord::Migration[4.2]
  def change
    add_column :sushi_applications, :description, :text
  end
end
