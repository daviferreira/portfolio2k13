class AddAttachmentFileToOpenSourceProjects < ActiveRecord::Migration
  def self.up
    change_table :open_source_projects do |t|
      t.attachment :file
    end
  end

  def self.down
    drop_attached_file :open_source_projects, :file
  end
end
