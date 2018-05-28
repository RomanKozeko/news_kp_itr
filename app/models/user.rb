class User < ApplicationRecord
  before_create :default_role, :default_name, :default_locale

  validates :name, uniqueness: true, presence: true, allow_blank: true, length: {maximum: 255}

  has_many :posts
  has_many :comments
  mount_uploader :avatar, AvatarUploader

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :confirmable, :validatable, :omniauthable,
         :omniauth_providers => [:vkontakte]

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.name = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.skip_confirmation!
    end
  end

  private

  def default_role
    self.role = "user"
  end

  def default_name
    self.name = self.email
  end

  def default_locale
    self.locale = "ru"
  end
end
