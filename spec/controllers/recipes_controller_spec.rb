require "rails_helper"

RSpec.describe RecipesController, type: :controller do
  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
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
