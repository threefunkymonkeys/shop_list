class CreateItems < ActiveRecord::Migration
  def self.up
    create_table :items do |t|
      t.references :list
      t.references :article
      t.float :price, :default => 0.0

      t.timestamps
    end
  end

  def self.down
    drop_table :items
  end
end
