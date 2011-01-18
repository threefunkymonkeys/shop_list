class AddQuantityToItems < ActiveRecord::Migration
  def self.up
    add_column :items, :quantity, :integer, :default => 1
  end

  def self.down
    remove_column :items, :quantity
  end
end
