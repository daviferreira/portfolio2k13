class CreatePhotos < ActiveRecord::Migration
  def self.up
    create_table :photos do |t|
      t.string :title
      t.integer :order
      t.integer :project_id

      t.timestamps
    end

    add_index :photos, :project_id
  end

  def self.down
    drop_table :photos
  end
end
