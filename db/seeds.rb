# Import recipes from JSON file
def extract_keywords(ingredients)
  ingredients.flat_map do |ingredient|
    ingredient.downcase.scan(/[a-z]+/)
  end.uniq
end

recipes = JSON.parse(File.read(Rails.root.join("db", "seeds", "recipes-en.json")))
recipes.each_slice(1000) do |recipes_slice|
  hashed_recipes = recipes_slice.map do |recipe|
    keywords = extract_keywords(recipe["ingredients"])
    recipe.merge!("keywords" => keywords)
    recipe.to_h
  end
  Recipe.insert_all(hashed_recipes)
end
