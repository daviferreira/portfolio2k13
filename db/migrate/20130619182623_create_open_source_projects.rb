class CreateOpenSourceProjects < ActiveRecord::Migration
  def change
    create_table :open_source_projects do |t|
      t.string :title
      t.text :description
      t.string :url

      t.timestamps
    end
  end
end
