class CategoriesController < ApplicationController
  def index
    @categories = Category.page(page_no).per(per_page)

    render json: {
      objects: @categories,
      meta: pagination_meta(@categories)
    }
  end
end
