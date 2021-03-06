class Post < ApplicationRecord
  has_many :taggings
  has_many :tags, through: :taggings, dependent: :destroy
  belongs_to :category
  belongs_to :user
  acts_as_commentable
  mount_uploader :preview, ImageUploader
  validates :title, presence: true, length: {maximum: 255}
  validates :summary, presence: true, length: {maximum: 255}
  validates :body, presence: true

  def all_tags
    self.tags.map(&:name).join(", ")
  end

  def all_tags=(names)
    self.tags = names.split(",").map do |name|
      Tag.where(name: name.strip).first_or_create!
    end
  end
end
