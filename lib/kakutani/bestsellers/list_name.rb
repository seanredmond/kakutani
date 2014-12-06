module Kakutani
  module Bestsellers
    # A description of a bestseller list
    #
    # @!method oldest
    #   The date of the oldest available version of this list.
    #   @return [Date]
    #
    # @!method newest
    #   The date of the most recent available version of this list.
    #   @return [Date]
    #
    # @!method list_name
    #   The name of the list. Example "Combined Print and E-Book Fiction"
    #   @see #list_name_encoded
    #   @see #display_name
    #   @return [String]
    #
    # @!method display_name
    #   A version of the list's name suitable for display to end users. The 
    #   main difference between this and {#list_name} seems to that display_name
    #   has an ampersand where the list_name has the word "and", for instance:
    #   "Combined Print & E-Book Fiction"
    #   @see #list_name
    #   @see #list_name_encoded
    #   @return [String]
    #
    # @!method list_name_encoded
    #   A version of the list's name suitable to be passed as a parameter to
    #   other methods. Example: "combined-print-and-e-book-fiction"
    #   @see #list_name
    #   @see #display_name
    #   @return [String]
    #
    # @!method updated
    #   Frequency with which the list is updated. Example: "WEEKLY"
    #   @return [String]
    class ListName < Resource
      attr_reader :oldest, :newest
      def initialize(data)
        super(data)
        @oldest = Date.strptime(oldest_published_date)
        @newest = Date.strptime(newest_published_date)
      end

      # URL of the API endpoint for this data
      # @return [String]
      def self.path
        Bestsellers::path('names')
      end
    end
  end
end
