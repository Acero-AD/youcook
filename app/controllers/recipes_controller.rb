class RecipesController < ApplicationController
  def index
    @recipes = Recipe.order(title: :desc).page(params[:page] || 1)
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  def search
    @recipes = Recipes::SearchRecipesByKeywordQuery.new(
      keywords: params[:ingredients], page: params[:page]
    ).call
  end
end
