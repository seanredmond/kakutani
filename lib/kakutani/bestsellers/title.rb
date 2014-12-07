module Kakutani
  module Bestsellers
    # A single title on a bestseller list. A Title does not represent a book,
    # but the appearance of a book on a bestseller list published on a
    # particular date. Many of many of a Title object's properties relate to its
    # position on that list that week and will be different when the same book
    # is retrieved for another date.
    #
    # @!method rank
    #   The serial rank of the title on the list from which it was retrieved
    #   @return [Fixnum]
    #
    # @!method rank_last_week 
    #   The serial rank of the title on the same list from
    #   it it was retrieved for the previous week. The value 0 indicates that
    #   the title was not on the list during the previous week.
    #   @return [Fixnum]
    #
    # @!method weeks_on_list
    #   How many weeks the title has been on the particular bestsellers
    #   list. The count is inclusive, so the value 1 indicates that it is the
    #   title's first week on the list.
    #   @return [Fixnum]
    #
    # @!method publisher
    #   The publisher of the title
    #   @return [String]
    #
    # @!method description
    #   Short description of the title
    #   @return [String]
    #
    # @!method title
    #   Title of the book
    #   @return [String]
    #
    # @!method author
    #   Author of the title. This property lists only the author's name, without
    #   information about additional contributors such as illustrators
    #   @see #contributor
    #   @see #contributor_note
    #   @return [String]
    #
    # @!method contributor
    #   Lists all contributors: authors, illustrators, translators, and so on,
    #   and includes text that describes each contributor's role
    #   @see #author
    #   @see #contributor_note
    #   @return [String]
    #
    # @!method contributor_note
    #   Lists all contributors other than the author (such as illustrators)
    #   @see #author
    #   @see #contributor
    #   @return [String]
    #
    # @!method book_image
    #   URL for cover image of the book
    #   @return [String]
    #
    # @!method amazon_product_url
    #   URL to buy the title from Amazon
    #   @return [String]
    #
    # @!method age_group
    #   Ages of the the intended audience for the book
    #   @return [String]
    #
    # @!book_review_link
    #   URL for New York Times review of the title
    #   @return [String]
    #
    # @!first_chapter_link
    #   URL for sample first chapter of the title
    #   @return [String]
    #
    # @!sunday_review_link
    #   URL for review of the title in the New York Times Sunday Book Review
    #   @return [String]
    #
    # @!article_chapter_link
    #   URL for sample chapter of the title
    #   @return [String]
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

      # The primary isbn10 and isbn13 for the title.
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

      # All isbns that can be associated with the title
      # @return [Array<Kakutani::Isbns>]
      def isbns
        @isbns
      end
    end
  end
end
