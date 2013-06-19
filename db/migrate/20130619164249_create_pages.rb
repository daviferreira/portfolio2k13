class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :title
      t.text :body
      t.boolean :published
      t.string :meta_description
      t.string :meta_title

      t.timestamps
    end
  end
end
