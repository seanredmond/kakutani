module Kakutani
  module Bookreviews
    class Review < Resource
      attr_reader :published, :isbns

      def initialize(data)
        @data = data
        @published = parse_date(data['publication_dt'])
        @isbns = data['isbn13']
      end

      def self.path
        Bookreviews::path
      end

      def parse_date(dt)
        DateTime.strptime(dt, '%Y-%m-%d %H:%M:%S').to_date

        # Sometimes the API returns invalid dates
        rescue ArgumentError
          return nil
      end
    end
  end
end
