module Api
  class RecipesController < ApplicationController
    before_action :set_recipe, only: [:show, :update, :destroy]
    def create
      recipe = Recipe.new(recipe_params)
      if recipe.save
        render json: { message: "Recipe successfully created!", recipe: recipe }
      else
        render json: { message: "Recipe creation failed!", required: "title, making_time, serves, ingredients, cost" }
      end
    end

    def index
      recipes = Recipe.all
      render json: { recipes: recipes }, except: [:created_at, :updated_at]
    end
    
    def show
      render json: { message: "Recipe details by id", recipe: @recipe }, except: [:created_at, :updated_at]
    end

    def update
      if @recipe.update(recipe_params)
        render json: { message: "Recipe successfully updated!", recipe: @recipe }, except: [:created_at, :updated_at]
      end
    end

    def destroy
      if @recipe.nil?
        render json: { message: "No Recipe found" }
      else
        @recipe.destroy
        render json: { message: "Recipe successfully removed!" }
      end
    end

    private

    def set_recipe
      @recipe = Recipe.find_by(id: params[:id])
    end

    def recipe_params
      params.require(:recipe).permit(:title, :making_time, :serves, :ingredients, :cost)
    end
    
  end
end
