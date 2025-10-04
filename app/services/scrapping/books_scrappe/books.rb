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

      def create_update_books
        Category.all.each do |category|
          p " checking category !!"
          p category.name

          html_books = get_all_books(category.url)

          p "I got all the books #{html_books.count}"

          html_books.each do |html_book|
            name  = html_book.css("h3 a").first.text
            p " going to create #{name}"

            price = html_book.css("div.product_price p.price_color").first.text
            price = price.gsub("£", '')

            qualification = html_book.css("p.star-rating").first.attribute_nodes.first.value.gsub("star-rating", ' ').strip()
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

      def get_all_books(category_url)
        new_books = true
        html_books = []
        url = category_url
        current_page = 1

        while new_books
          url.gsub!(/(?:index\.html|page-\d+\.html)/, "page-#{current_page}.html") if !(current_page == 1)

          document = get_document(url: url)
          current_page += 1

          new_books = false if document.css("article.product_pod").empty?
          html_books += document.css("article.product_pod")
        end

        html_books
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
          Book.create!(
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
