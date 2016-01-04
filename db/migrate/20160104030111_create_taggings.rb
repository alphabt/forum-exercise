class CreateTaggings < ActiveRecord::Migration
  def change
    create_table :taggings do |t|
      t.integer :tag_id
      t.integer :topic_id

      t.timestamps null: false
    end
    add_index :taggings, :tag_id
    add_index :taggings, :topic_id
  end
end
