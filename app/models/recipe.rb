class Recipe < ApplicationRecord
  validates :ratings, inclusion: { in: 0..5.00 }
  before_save :extract_keywords

  private

  def extract_keywords
    self.keywords = ingredients.flat_map do |ingredient|
      ingredient.downcase.scan(/[a-z]+/)
    end.uniq
  end
end
