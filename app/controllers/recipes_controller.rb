class RecipesController < ApplicationController
  def index
    @recipes = Recipe.page(params[:page] || 1).per(9)
  end

  def show
    @recipes = Recipe.find(params[:id])
  end

  def edit
  end

  def update
  end
end
