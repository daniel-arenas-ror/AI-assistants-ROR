class BooksController < ApplicationController
  def index
    @books = Book.page(page_no).per(per_page)

    render json: {
      objects: @books,
      meta: pagination_meta(@books)
    }
  end
end