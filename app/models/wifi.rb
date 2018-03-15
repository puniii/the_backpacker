class Wifi < ApplicationRecord
  belongs_to :post,optional: true
  # inverse_of: :wifi
  # validates :condition_1
  # validates :condition_2
  # validates :condition_3, presence: true
end
