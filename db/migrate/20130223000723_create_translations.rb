class CreateTranslations < ActiveRecord::Migration
  def up
    Project.create_translation_table!({:name => :string, :description => :text, :tags => :string}, {:migrate_data => true})
    Category.create_translation_table!({:name => :string}, {:migrate_data => true})
    Photo.create_translation_table!({:title => :string}, {:migrate_data => true})
    Post.create_translation_table!({:title => :string, :abstract => :text, :body => :text, :tags => :string}, {:migrate_data => true})
  end

  def down
    Project.drop_translation_table! :migrate_data => true
    Category.drop_translation_table! :migrate_data => true
    Photo.drop_translation_table! :migrate_data => true
    Post.drop_translation_table! :migrate_data => true
  end
end
