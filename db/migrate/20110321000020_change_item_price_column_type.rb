class ChangeItemPriceColumnType < ActiveRecord::Migration
  def self.up
    change_column :items, :price, :integer
  end

  def self.down 
    change_column :items, :price, :float
  end
end
