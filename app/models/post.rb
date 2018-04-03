class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  acts_as_taggable

  validates :text, presence: true
  mount_uploader :image, ImageUploader

  scope :filter_by_author, -> (author) { joins(:user).where(users: { login: author }) }
  scope :filter_by_content, -> (phrase) { where ('text LIKE ?'), "%#{phrase}%" }
  scope :filter_by_address, -> (address) { joins(:user).where('users.address LIKE ?', "%#{address}%") }
end
