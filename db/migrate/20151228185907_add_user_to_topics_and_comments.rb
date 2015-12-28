class AddUserToTopicsAndComments < ActiveRecord::Migration
  def change
    add_column :topics, :user_id, :integer
    add_column :comments, :user_id, :integer
    add_index :topics, :user_id
    add_index :comments, :user_id
  end
end
