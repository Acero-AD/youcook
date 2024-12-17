module Recipes
  class SearchRecipesByKeywordQuery
    def initialize(keywords:, page: 1)
      @keywords = keywords&.map(&:downcase)
      @page = page
    end

    def call
      Recipe.with_keywords(@keywords).order(ratings: :desc).page(@page)
    end
  end
end
