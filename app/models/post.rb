class Post < ApplicationRecord
  
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :users, through: :likes, source: :user
  has_many :comments, dependent: :destroy
  has_many :wifis
  has_many :toilets
  has_many :troubles


  accepts_nested_attributes_for :wifis
  accepts_nested_attributes_for :toilets
  accepts_nested_attributes_for :troubles


  validates :content, presence: true
  validates :content,length:{maximum:500}
  validates :spot, presence: true
  mount_uploader :image, ImageUploader
end
