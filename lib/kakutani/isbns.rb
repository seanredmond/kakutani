module Kakutani
  # Pairs of ISBNs with equivalent ISBN10 and ISBN13 versions
  # @note either the {#isbn10} or the {#isbn13} can be nil.
  #
  # @!attribute isbn10 [r]
  #   The isbn10 of a title.
  #   @return [String, nil]
  # 
  # @!attribute isbn13 [r]
  #   The isbn13 of a title.
  #   @return [String, nil]
  class Isbns
    attr_reader :isbn10, :isbn13
    def initialize(isbn10, isbn13)
      @isbn10 = isbn10 == "None" ? nil : isbn10
      @isbn13 = isbn13 == "None" ? nil : isbn13
    end
  end
end

