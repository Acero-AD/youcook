class Recipe < ApplicationRecord
  include PgSearch::Model
  paginates_per 9

  validates :ratings, inclusion: { in: 0..5.00, message: "must be between 0.0 and 5.0" }

  pg_search_scope :search_by_ingredients,
                  using: {
                    tsearch: {
                      dictionary: "english",
                      tsvector_column: "ingredients_vector",
                      any_word: false,
                      normalization: 2,
                      prefix: true
                    }
                  }

  def self.search_ingredients(query:, page:)
    if query.present?
      search_terms = query.downcase.strip
      search_by_ingredients(search_terms).reorder(ratings: :desc).page(page)
    else
      page(page)
    end
  end

  def display_image
    return image unless image.include?("imagesvc.meredithcorp.io")

    uri = URI(image)
    params = URI.decode_www_form(uri.query).to_h
    params["url"]
  end
end
