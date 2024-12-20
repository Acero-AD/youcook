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
end
