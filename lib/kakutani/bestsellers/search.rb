module Kakutani
  module Bestsellers
    class Search < Resource
      attr_reader :book_details
      def initialize(data)
        super(data)
        @book_details = data['book_details'].map{|d| BookDetails.new(d)}
      end

      # URL of the API endpoint for this data
      # @return [String]
      def self.path
        Bestsellers::path
      end
    end
  end
end
