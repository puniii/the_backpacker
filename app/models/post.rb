class Post < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :users, through: :likes, source: :user
  has_many :comments
  has_many :wifis
  accepts_nested_attributes_for :wifis
  has_many :toilets
  accepts_nested_attributes_for :toilets
  has_many :troubles
  accepts_nested_attributes_for :troubles

  validates :content, presence: true
  validates :content,length:{maximum:200}
  # validates :spot, presence: true
  mount_uploader :image, ImageUploader
end
