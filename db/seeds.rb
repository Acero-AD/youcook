recipes = JSON.parse(File.read(Rails.root.join("db", "seeds", "recipes-en.json")))
recipes.each_slice(1000) do |recipes_slice|
  hashed_recipes = recipes_slice.map(&:to_h)
  Recipe.insert_all(hashed_recipes)
end
