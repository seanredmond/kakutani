module Kakutani
  module Bestsellers   
    class ListName < Resource
      attr_reader :oldest, :newest
      def initialize(data)
        super(data)
        @oldest = Date.strptime(oldest_published_date)
        @newest = Date.strptime(newest_published_date)
      end

      def self.path
        Bestsellers::path('names')
      end
    end
  end
end
