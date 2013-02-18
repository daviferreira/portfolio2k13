class AddScopeToCategory < ActiveRecord::Migration
  def change
    add_column :categories, :scope, :string
  end
end
