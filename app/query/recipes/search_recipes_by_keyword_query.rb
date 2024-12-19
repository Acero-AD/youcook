module Recipes
  class SearchRecipesByKeywordQuery
    def initialize(keywords:, page: 1)
      @keywords = keywords
      @page = page
    end

    def call
      Recipe.search_ingredients(query: @keywords, page: @page)
    end
  end
end
