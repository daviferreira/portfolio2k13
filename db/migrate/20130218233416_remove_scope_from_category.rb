class RemoveScopeFromCategory < ActiveRecord::Migration
  def up
    remove_column :categories, :scope
  end

  def down
    add_column :categories, :scope, :string
  end
end
