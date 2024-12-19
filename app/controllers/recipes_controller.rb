class RecipesController < ApplicationController
  def index
    @recipes = Recipe.order(title: :asc).page(params[:page] || 1)
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  def search
    @recipes = Recipes::SearchRecipesByKeywordQuery.new(
      keywords: params[:keywords], page: params[:page]
    ).call

    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end

  def new
    @recipe = Recipe.new
  end

  def create
    response = CreateRecipeCommand.new(recipe_params.to_h).call
    if response[:success]
      redirect_to recipe_path(response[:recipe])
    else
      @recipe = response[:recipe]
      @errors = response[:errors]
      render :new, status: :unprocessable_entity
    end
  end

  private

  def recipe_params
    params.require(:recipe)
    .permit(
      :title,
      :prep_time,
      :ratings,
      :image,
      :cook_time,
      :author,
      :cuisine,
      :category,
      ingredients: []
    )
  end
end
