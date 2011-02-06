class List < ActiveRecord::Base
  validates :name, :presence => true

  belongs_to :user
  has_many :items

  accepts_nested_attributes_for :items, :allow_destroy => true, 
    :reject_if => proc { |attrs| attrs.all? { |k, v| v.blank? } }

  def total
    items.inject(0) { |total, item| total + item.quantity * item.price }
  end
end
