class Post < ApplicationRecord
  has_many :taggings
  has_many :tags, through: :taggings
  validates :title, :summary, :body, presence: true
end
