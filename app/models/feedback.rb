class Feedback < ActiveRecord::Base
  validates :content, :presence => true
  validates :email, :presence => true
end
