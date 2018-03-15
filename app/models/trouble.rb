class Trouble < ApplicationRecord
  belongs_to :post,optional: true
  # inverse_of: :trouble
end
