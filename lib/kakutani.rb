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

module Kakutani
  @url = 'http://api.nytimes.com/svc/books/v3'
  def self.path(sub)
    ([@url] + sub).join('/')
  end
end
