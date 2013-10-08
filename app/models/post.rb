class Post < ActiveRecord::Base
  attr_accessible :published, :link, :body

  validates :link, :body, presence: true
end
