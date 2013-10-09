class Post < ActiveRecord::Base
  attr_accessible :published, :link, :body

  validates :link, :body, presence: true
  validates :link, format: /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$/ix
end
