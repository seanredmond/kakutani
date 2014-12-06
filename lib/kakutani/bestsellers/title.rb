module Kakutani
  module Bestsellers
    # A single title on a bestseller list
    class Title < Resource
      def initialize(data)
        super(data)
        @primary_isbns = Kakutani::Isbns.new(primary_isbn10, primary_isbn13)
        @price = data['price'].to_f
        @isbns = data['isbns'].map{|i| 
          Kakutani::Isbns.new(i['isbn10'], i['isbn13'])
        }
      end


      # Whether or not the title was on the same list the previous week
      def ranked_previous_week?
        return rank_last_week != 0
      end

      # Whether or not the title has an asterisk, indicating that a book's sales
      # are barely distinguishable from those of the book above it
      def asterisk?
        return asterisk != 0
      end

      # Whether or not the title has a dagger, indicating that some retailers
      # report receiving bulk orders
      def dagger?
        return dagger != 0
      end

      # Primary ISBNs for the title.
      # @return [Kakutani::Isbns]
      def primary_isbns
        @primary_isbns
      end

      # Price of the book
      # @note Not returned for most titles
      # @return [Float]
      def price
        @price
      end

      def isbns
        @isbns
      end
    end
  end
end
