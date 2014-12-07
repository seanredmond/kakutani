require "date"
require "faraday"
require "json"
require "kakutani/resource"
require "kakutani/bookreviews"
require "kakutani/bookreviews/review"
require "kakutani/client"
require "kakutani/error"
require "kakutani/version"
require "kakutani/bestsellers"
require "kakutani/bestsellers/list"
require "kakutani/bestsellers/list_name"
require "kakutani/bestsellers/title"

# Library for accessing New York Times Books API
module Kakutani
  @url = 'http://api.nytimes.com/svc/books/v3'
  def self.path(sub)
    ([@url] + sub).join('/')
  end

  # Pairs of ISBNs with equivalent ISBN10 and ISBN13 versions
  Isbns = Struct.new(:isbn10, :isbn13)
end
