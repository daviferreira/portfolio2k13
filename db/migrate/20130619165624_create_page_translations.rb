class CreatePageTranslations < ActiveRecord::Migration
  def self.up
    say_with_time("Creating Page translation table") do
      Page.create_translation_table!({
        :title => :string,
        :body => :text,
        :meta_title => :string,
        :meta_description => :string,
        :cached_slug => :string
      }, {
        :migrate_data => true
      })
    end
  end

  def self.down
    Page.drop_translation_table! :migrate_data => true
  end
end
