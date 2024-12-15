class Recipe < ApplicationRecord
  validates :ratings, inclusion: { in: 0..5.00 }
end
