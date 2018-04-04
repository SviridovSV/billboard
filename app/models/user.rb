class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:facebook]

  has_many :posts, dependent: :destroy
  has_many :comments

  validates :login, :first_name, :last_name, :birthday, :address, :city,
            :state, :country, :zip, :email, presence: true
  validates :zip, numericality: true
  validates :login, uniqueness: { case_sensitive: false }

  geocoded_by :full_address
  before_save :geocode

  enum role: [:moderator, :admin]

  def self.from_omniauth(auth)
    where(email: auth.info.email).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
    end
  end

  def full_address
    [address, city, state, country].compact.join(', ')
  end

  def full_name
    "#{first_name} #{last_name}"
  end
end
