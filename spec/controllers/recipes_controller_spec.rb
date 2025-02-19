require "rails_helper"

RSpec.describe RecipesController, type: :controller do
  describe "GET #index" do
    let(:recipes_amount) { Recipe.default_per_page + second_page_recipes_amount }
    let(:second_page_recipes_amount) { 5 }
    before do
      (1..recipes_amount).each do |i|
        create(:recipe, title: "title_#{i}")
      end
    end

    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "returns the correct number of recipes" do
      get :index
      recipes = controller.view_assigns['recipes']
      expect(recipes.count).to eq(Recipe.default_per_page)
    end

    it "returns the correct number of recipes for page 2" do
      get :index, params: { page: 2 }
      recipes = controller.view_assigns['recipes']
      expect(recipes.count).to eq(5)
    end
  end

  describe "GET #show" do
    let!(:recipe_1) { create(:recipe, title: "apples", ingredients: %w[apples pears]) }

    it "returns http success" do
      get :show, params: { id: recipe_1.id }
      expect(response).to have_http_status(:success)
    end

    it "returns the correct recipe" do
      get :show, params: { id: recipe_1.id }
      recipe = controller.view_assigns['recipe']
      expect(recipe.title).to eq(recipe_1.title)
      expect(recipe.ingredients).to eq(recipe_1.ingredients)
      expect(recipe.ratings).to eq(recipe_1.ratings)
    end
  end

  describe "GET #search" do
    let!(:recipe_1) { create(:recipe, title: "apples", ingredients: %w[apples pears oil]) }
    let!(:recipe_2) { create(:recipe, title: "pears", ingredients: %w[pears oranges]) }
    let!(:recipe_3) { create(:recipe, title: "oranges", ingredients: %w[oranges apples]) }

    it "returns http success" do
      get :search, params: { keywords: "apples" }
      expect(response).to have_http_status(:success)
    end

    it "returns the correct number of recipes" do
      get :search, params: { keywords: "apples" }
      recipes = controller.view_assigns['recipes']
      expect(recipes.count).to eq(2)
    end

    it "returns page if no keywords sent" do
      get :search, params: { keywords: "" }
      recipes = controller.view_assigns['recipes']
      expect(recipes.count).to eq(3)
    end

    it "returns empty recipes if no recipe match keywords " do
      get :search, params: { keywords: "none" }
      recipes = controller.view_assigns['recipes']
      expect(recipes).to be_empty
    end

    it "only returns recipes with all matching keywords" do
      get :search, params: { keywords: "apples oil" }
      recipes = controller.view_assigns['recipes']
      expect(recipes.count).to eq(1)
    end
  end

  describe "POST #create" do
    let(:recipe_params) do
      {
        title: "apples",
        ingredients: %w[apples pears],
        ratings: 5,
        prep_time: 10,
        cook_time: 20,
        author: "John Doe",
        cuisine: "Italian",
        category: "mains"
      }
    end

    it "returns http success" do
      post :create, params: { recipe: recipe_params }
      expect(response).to have_http_status(:found)
    end

    it "returns the correct recipe" do
      post :create, params: { recipe: recipe_params }
      recipe = Recipe.last
      expect(recipe.title).to eq(recipe_params[:title])
      expect(recipe.ingredients).to eq(recipe_params[:ingredients])
      expect(recipe.ratings).to eq(recipe_params[:ratings])
      expect(recipe.prep_time).to eq(recipe_params[:prep_time])
      expect(recipe.cook_time).to eq(recipe_params[:cook_time])
      expect(recipe.author).to eq(recipe_params[:author])
      expect(recipe.cuisine).to eq(recipe_params[:cuisine])
      expect(recipe.category).to eq(recipe_params[:category])
    end

    it "returns errors if recipe is invalid" do
      post :create, params: { recipe: { title: "" } }
      expect(response).to have_http_status(:unprocessable_entity)
      expect(controller.view_assigns['recipe']).to be_nil
      expect(controller.view_assigns['errors']).to be_present
    end
  end
end
