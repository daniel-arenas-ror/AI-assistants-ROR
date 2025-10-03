module Scrapping
  module BooksScrappe
    class Categories < Base

      attr_reader :category_shape
      def initialize
        super

        @category_shape = Struct.new(:name, :url) do
          def clear_name
            name.gsub("\n", ' ').gsub(" ", "")
          end
        end
      end

      def create_categories
        read_categories.each do |new_category|
          category = Category.find_by_name(new_category.clear_name)

          if category.nil?
            category = Category.create!(
              name: new_category.clear_name,
              url: new_category.url
            )
          end

          category.update!(
            name: new_category.clear_name,
            url: "#{URL}#{new_category.url}"
          )
        end
      end

      def read_categories
        categories = []
        document = get_document
        side_categories = document.css("div.side_categories")
        html_categories = side_categories.css("ul.nav-list li ul li")

        html_categories.each do |category_html|
          url  = category_html.css("a").first.attribute("href").value
          name = category_html.css("a").first.text
          category = @category_shape.new(name, url)

          categories.push(category)
        end

        categories
      end
    end
  end
end
