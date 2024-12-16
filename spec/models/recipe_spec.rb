require 'rails_helper'

RSpec.describe Recipe, type: :model do
  describe "Validations" do
    it "should not be valid when ratings is bigger than 5" do
      recipe = build(:recipe, ratings: 5.5)
      expect(recipe).to be_invalid
      expect(recipe.errors.messages[:ratings]).to include("must be between 0.0 and 5.0")
    end

    it "should not be valid when ratings is smaller than 0" do
      recipe = build(:recipe, ratings: -0.5)
      expect(recipe).to be_invalid
      expect(recipe.errors.messages[:ratings]).to include("must be between 0.0 and 5.0")
    end
  end

  describe "extract_keywords" do
    it "should extract keywords from ingredients" do
      recipe = create(:recipe)
      expect(recipe.keywords).to eq(%w[apples oranges pears])
    end

    it "should not have duplicate keywords" do
      recipe = create(:recipe, ingredients: %w[apples oranges pears apples])
      expect(recipe.keywords).to eq(%w[apples oranges pears])
    end

    it "should not have numbers in keywords" do
      recipe = create(:recipe, ingredients: %w[apples 123 oranges pears])
      expect(recipe.keywords).to eq(%w[apples oranges pears])
    end
  end
end
