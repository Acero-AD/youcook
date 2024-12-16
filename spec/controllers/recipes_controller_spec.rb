require "rails_helper"

RSpec.describe RecipesController, type: :controller do
  let(:recipes_amount) { Recipe.default_per_page + second_page_recipes_amount }
  let(:second_page_recipes_amount) { 5 }
  before do
    (1..recipes_amount).each do |i|
      create(:recipe, title: "title_#{i}")
    end
  end
  describe "GET #index" do
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
    it "returns http success" do
      get :show, params: { id: 1 }
      expect(response).to have_http_status(:success)
    end
  end
  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
   end

   describe "POST #create" do
     let(:recipe) { attributes_for(:recipe) }
     it "returns http success" do
       post :create, params: { recipe: recipe }
       expect(response).to have_http_status(:success)
     end
   end
end
