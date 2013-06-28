class AddCategoryToProject < ActiveRecord::Migration
  def self.up
    add_column :projects, :category_id, :integer
    add_index :projects, :category_id
  end

  def self.down
    drop_column :projects, :category_id
  end
end
