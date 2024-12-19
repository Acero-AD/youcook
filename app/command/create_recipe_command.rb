class CreateRecipeCommand
  def initialize(params)
    @params = params
  end

  def call
    recipe = Recipe.create(@params)
    return failure(recipe.errors.full_messages) if recipe.errors.any?
    success(recipe)
  end

  private

  def success(recipe)
    {
      success: true,
      recipe: recipe
    }
  end

  def failure(errors)
    {
      success: false,
      errors: errors
    }
  end
end
