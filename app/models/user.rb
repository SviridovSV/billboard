class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:facebook]

  has_many :posts, dependent: :destroy

  # validates :login, :first_name, :last_name, :birthday, :address, :city,
  #           :state, :country, :zip, :email, presence: true
  # validates :zip, numericality: true
  # validates :country, :first_name, :last_name, format: { with: /\A[a-zA-Z]+\z/,
  #                               message: 'Only letters allowed' }
  # validates :login, :uniqueness => { :case_sensitive => false }

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
    end
  end
end
