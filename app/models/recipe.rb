class Recipe < ApplicationRecord
  validates :ratings, inclusion: { in: 0..5.00, message: "must be between 0.0 and 5.0" }
  before_save :extract_keywords

  private

  def extract_keywords
    self.keywords = ingredients.flat_map do |ingredient|
      ingredient.downcase.scan(/[a-z]+/)
    end.uniq
  end
end
