module Scrapping
  module BooksScrappe
    class Books < Base

      STARTS = {
        'One' => 1,
        'Two' => 2,
        'Three' => 3,
        'Four' => 4,
        'Five' => 5,
      }

      def initialize
      end

      def create_books
        Category.all.each do |category|
          document = get_document(category.url)
          ## Pagination ##

          html_books = document.css("article.product_pod")

          html_books.each do |html_book|
            name  = html_book.css("h3 a").first.text
            price = html_book.css("div.product_price p.price_color").first.text
            qualification = books.css("p.star-rating").first.attribute_nodes.first.value.gsub("star-rating", ' ').strip()
            qualification = STARTS[qualification]

            create_update_book(
              name: name,
              price: price,
              qualification: qualification,
              category: category
            )
          end
        end
      end

      private

      def create_update_book(
        name: nil,
        price: nil,
        qualification: nil,
        category: nil
      )
        
        book = Book.find_by(
          name: name,
          category: category
        )

        if book
          book.update!(
            price: price,
            qualification: qualification
          )
        else
          book.create!(
            name: name,
            category: category,
            price: price,
            qualification: qualification
          )
        end
      end
    end
  end
end
