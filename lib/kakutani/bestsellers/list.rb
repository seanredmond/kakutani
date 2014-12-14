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
    #   The date of the end of the week for which the rankings were
    #   compiled. This differs from {#published} because of the lag in
    #   collecting data.
    #   @see #published
    #   @return [Date]
    #
    # @!method published
    #   The date the list was published in the New York Times.
    #   @see #date
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
      attr_reader :date, :published, :name, :books
      def initialize(data, opts={})
        super(data)
        @date      = opt_date(data['bestsellers_date'], opts[:list_date])
        @published = opt_date(data['published_date'], opts[:pub_date])
        @name      = list_name
        @books     = data['books'].map{|b| Title.new(b)}
      end

      # URL of the API endpoint for this data
      # @param date [Date] The date of the requested list
      # @param name [String] The name of the requested list
      # @return [String]
      def self.path(date, name)
        Bestsellers::path([date.to_s, name])
      end

      private
      # Get list date from data or optional params
      def opt_date(from_data, opt_date=nil)
        if opt_date.nil?
          return nil if from_data.nil?
          return Date.strptime(from_data)
        end
        return Date.strptime(opt_date)
      end
    end
  end
end
