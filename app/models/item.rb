class Item < ActiveRecord::Base
  belongs_to :list
  belongs_to :article

  validates :list_id, :presence => true
  validates :article_id, :presence => true
  validates :price, :numericality => true
  validates :quantity, :numericality => true

  class ItemValidator
    def validate item
      item.errors[:base] << "Price should be greater than zero" unless item.price > 0

      item.errors[:base] << "Quantity should be greater than zero" unless item.quantity > 0
    end
  end

  validates_with ItemValidator
end
