class Article < ActiveRecord::Base
  belongs_to :user

  validates :name, :presence => true
  validates_uniqueness_of :name, :scope => :user_id

  scope :for_list, lambda { |list|
    select([:id, :name]).where("id NOT IN (?)", list.items.map(&:article_id)) if list.items.any?
  }
end
