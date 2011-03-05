class User < ActiveRecord::Base
  acts_as_authentic
  has_many :lists
  has_many :articles
end
