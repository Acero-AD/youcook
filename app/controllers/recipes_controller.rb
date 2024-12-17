class RecipesController < ApplicationController
  def index
    @recipes = Recipe.order(title: :desc).page(params[:page] || 1)
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  def search
    @recipes = Recipes::SearchRecipesByKeywordQuery.new(
      keywords:, page: params[:page]
    ).call

    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end

  private

  def keywords
    return [] if params[:keywords].blank?
    params[:keywords].split(/[\s,]+/).map(&:downcase)
  end
end
