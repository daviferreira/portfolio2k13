class AddCachedSlugToCategoriesTranslations < ActiveRecord::Migration
  def up
    Category.translated_attribute_names = [:name, :cached_slug]
    add_column :category_translations, :cached_slug, :string
  end

  def down
    remove_column :category_translations, :cached_slug
  end
end
