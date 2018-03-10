class Post < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :users, through: :likes, source: :user
  has_many :comments
  has_many :wifis
  has_many :toilets
  has_many :troubles

  validates :content, presence: true
  validates :content,length:{maximum:200}
  mount_uploader :image, ImageUploader
end
