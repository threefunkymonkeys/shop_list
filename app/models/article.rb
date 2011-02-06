class Article < ActiveRecord::Base
  validates :name, :uniqueness => true, :presence => true

  scope :for_list, lambda { |list|
    select([:id, :name]).where("id NOT IN (?)", list.items.map(&:article_id)) if list.items.any?
  }
end
