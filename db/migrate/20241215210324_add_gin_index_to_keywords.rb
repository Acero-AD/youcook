class AddGinIndexToKeywords < ActiveRecord::Migration[8.0]
  def change
    add_index :recipes, :keywords, using: :gin
  end
end
