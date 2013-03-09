class AddCachedSlugToProjectsTranslations < ActiveRecord::Migration
  def up
    Project.translated_attribute_names = [:name, :description, :tags, :cached_slug]
    add_column :project_translations, :cached_slug, :string
  end

  def down
    remove_column :project_translations, :cached_slug
  end
end
