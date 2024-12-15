class AddKeyWordsToRecipes < ActiveRecord::Migration[8.0]
  def change
    add_column :recipes, :keywords, :string, array: true, null: false
  end
end
