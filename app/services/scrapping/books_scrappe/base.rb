module Scrapping
  module BooksScrappe
    class Base
      URL = "https://books.toscrape.com/"

      attr_reader :document, :headers

      def initialize
        @headers = {
          "user-Agent" => "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/109.0.0.0 Safari/537.36"
        }
      end

      def get_document(url: nil)
        response = HTTParty.get((url || URL), { headers: @headers })
        @document = Nokogiri::HTML(response.body)
      end
    end
  end
end
