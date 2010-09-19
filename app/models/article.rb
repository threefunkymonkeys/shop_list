class Article < ActiveRecord::Base
  validates :name, :uniqueness => true
end
