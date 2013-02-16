class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string :title
      t.integer :order
      t.integer :project_id

      t.timestamps
    end
  end
end
