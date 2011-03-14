class AddPriceToArticles < ActiveRecord::Migration
  def self.up
    add_column :articles, :last_price, :integer, :allow_nil => false, :default => 0
  end

  def self.down 
    remove_column :articles, :last_price
  end
end
