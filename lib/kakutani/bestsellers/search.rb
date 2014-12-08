module Kakutani
  module Bestsellers
    class Search < Resource
      # URL of the API endpoint for this data
      # @return [String]
      def self.path
        Bestsellers::path
      end
    end
  end
end
