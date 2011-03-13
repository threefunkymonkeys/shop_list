class AddUserToArticle < ActiveRecord::Migration
  def self.up
    add_column :articles, :user_id, :integer, :allow_nil => false
  end

  def self.down 
    remove_column :articles, :user_id
  end
end
