module Kakutani
  module Bestsellers
    # A bestseller list published on a given date
    #
    # @!method name
    #   The name of the list. Example "Combined Print and E-Book Fiction"
    #   @see #display_name
    #   @return [String]
    #
    # @!method display_name
    #   A version of the list's name suitable for display to end users. The main
    #   difference between this and {#list_name} seems to that display_name has
    #   an ampersand where the list_name has the word "and", for instance:
    #   "Combined Print & E-Book Fiction"
    #   @see #list_name
    #   @return [String]
    #
    # @!method date
    #   The date of the list. In most instances you want to refer to 
    #   {#published} instead
    #   @return [Date]
    #
    # @!method published
    #   The date the list was published in the New York Times
    #   @return [Date]
    #
    # @!method books
    #   The list of books in ranked order
    #   @return [Array]
    #
    # @!method corrections
    #   Corrections to the list as first published
    #   @return [Array]
    #
    # @!method normal_list_ends_at
    #   Number of items normally on the published list. Lists returned from the
    #   API usually have more.
    #   @return [Fixnum]
    #
    # @!method updated
    #   Frequency with which the list is updated. Example: "WEEKLY"
    #   @return [String]
    class List < Resource
      attr_reader :date, :published, :name
      def initialize(data)
        super(data)
        @date = Date.strptime(bestsellers_date)
        @published = Date.strptime(published_date)
        @name = list_name
      end

      # URL of the API endpoint for this data
      # @param date [Date] The date of the requested list
      # @param name [String] The name of the requested list
      # @return [String]
      def self.path(date, name)
        Bestsellers::path([date.to_s, name])
      end
    end
  end
end
