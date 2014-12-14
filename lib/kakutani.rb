require "date"
require "faraday"
require "json"
require "kakutani/resource"
require "kakutani/bookreviews"
require "kakutani/bookreviews/review"
require "kakutani/client"
require "kakutani/error"
require "kakutani/version"
require "kakutani/isbns"
require "kakutani/bestsellers"
require "kakutani/bestsellers/age_group"
require "kakutani/bestsellers/book_details"
require "kakutani/bestsellers/list"
require "kakutani/bestsellers/list_name"
require "kakutani/bestsellers/overview"
require "kakutani/bestsellers/search"
require "kakutani/bestsellers/title"

# Library for accessing New York Times Books API
module Kakutani
  @url = 'http://api.nytimes.com/svc/books/v3'
  def self.path(sub)
    ([@url] + sub).join('/')
  end
end
