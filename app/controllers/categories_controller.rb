class CategoriesController < ApplicationController
  def index
    @categories = Category.all

    render json: @categories.then(&paginate)
  end
end
