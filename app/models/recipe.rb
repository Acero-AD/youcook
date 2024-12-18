class Recipe < ApplicationRecord
  paginates_per 9

  validates :ratings, inclusion: { in: 0..5.00, message: "must be between 0.0 and 5.0" }
  before_save :extract_keywords

  scope :with_keywords, ->(search_values) { where("keywords @> ARRAY[?]::varchar[]", search_values) }

  def display_image
    return image unless image.include?("imagesvc.meredithcorp.io")

    uri = URI(image)
    params = URI.decode_www_form(uri.query).to_h
    params["url"]
  end
  private

  def extract_keywords
    self.keywords = ingredients.flat_map do |ingredient|
      ingredient.downcase.scan(/[a-z]+/)
    end.uniq
  end
end
