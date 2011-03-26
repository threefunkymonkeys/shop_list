class List < ActiveRecord::Base
  validates :name, :presence => true

  belongs_to :user
  has_many :items

  accepts_nested_attributes_for :items, :allow_destroy => true,
    :reject_if => proc { |attrs| attrs.all? { |k, v| v.blank? } }

  def total
    items.inject(0) { |sum, item| sum + item.quantity * item.price }
  end

  def << new_item
    item = items.find_by_article_id(new_item.article_id)

    if item.nil?
      item = new_item
    else
      item.quantity += new_item.quantity
    end

    item.save
    items << item
  end

  def deep_clone
    list = self.clone
    count = List.count(:all, :conditions => ['name LIKE "? (%)"', self.name])
    list.name = "#{list.name} (#{count + 1})"
    list.save!
    self.items.each do |item|
      list.items << Item.new(item.attributes)
    end
    list
  end
end
