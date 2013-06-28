class CreateOpenSourceProjectTranslations < ActiveRecord::Migration
  def self.up
    say_with_time("Creating OpenSourceProject translation table") do
      OpenSourceProject.create_translation_table!({
        :title => :string,
        :description => :text
      }, {
        :migrate_data => true
      })
    end
  end

  def self.down
    OpenSourceProject.drop_translation_table! :migrate_data => true
  end
end
