class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable

  has_many :posts

  validates :login, :first_name, :last_name, :birthday, :address, :city,
            :state, :country, :zip, :email, presence: true
  validates :zip, numericality: true
  validates :country, :first_name, :last_name, format: { with: /\A[a-zA-Z]+\z/,
                                message: 'Only letters allowed' }
  validates :login, :uniqueness => { :case_sensitive => false }
end
