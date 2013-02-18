class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.text :abstract
      t.text :body
      t.date :published_date
      t.string :meta_title
      t.string :meta_description
      t.boolean :block_comments
      t.boolean :published
      t.string :external_url

      t.timestamps
    end
  end
end
