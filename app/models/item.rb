class Item < ActiveRecord::Base
  belongs_to :list
  belongs_to :article

  validates :list_id, :presence => true
  validates :article_id, :presence => true
  validates_numericality_of :price
  validates_numericality_of :quantity, :greater_than => 0
end
