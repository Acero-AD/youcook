class RemoveKeywordsFieldFromRecipe < ActiveRecord::Migration[8.0]
  def change
    remove_column :recipes, :keywords, :string
  end
end
