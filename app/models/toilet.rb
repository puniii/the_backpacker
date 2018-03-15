class Toilet < ApplicationRecord
  belongs_to :post,optional: true
  # inverse_of: :toilet
end
