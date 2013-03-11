class CreateTranslations < ActiveRecord::Migration
  def up
    Project.translated_attribute_names = [:name, :description, :tags]
    Category.translated_attribute_names = [:name]
    Project.create_translation_table!({:name => :string, :description => :text, :tags => :string}, {:migrate_data => true})
    Category.create_translation_table!({:name => :string}, {:migrate_data => true})
    Photo.create_translation_table!({:title => :string}, {:migrate_data => true})
  end

  def down
    Project.drop_translation_table! :migrate_data => true
    Category.drop_translation_table! :migrate_data => true
    Photo.drop_translation_table! :migrate_data => true
  end
end
