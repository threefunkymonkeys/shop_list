class Item < ActiveRecord::Base
  belongs_to :list
  belongs_to :article
  validates :list_id, :presence => true
  validates :article_id, :presence => true
  validates :price, :numericality => true
end
