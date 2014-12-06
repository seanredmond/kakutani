module Kakutani
  # Client for the NYTimes Books API
  class Client
    @@server = 'http://api.nytimes.com'
    @@base_uri = '/svc/books/v3'

    # @param api_key [String] Your registered API key. See 
    #   {http://developer.nytimes.com/docs/reference/keys Requesting A Key}
    def initialize(api_key)
      @api_key = api_key
      @conn = Faraday.new(:url => @@server)
    end

    # Get a list of all available bestseller lists. This is first stop to get
    # the parameter values you will need to request Bestseller data from 
    # {#bestseller_list}. Requesting a list requires a list name and a date,
    # which correspond, respectively, to 
    # {Bestsellers::ListName#list_name_encoded} values and date ranges 
    # specified by {Bestsellers::ListName#oldest} and 
    # {Bestsellers::ListName#newest}
    # @return [Array<Bestsellers::ListName>] An array of descriptions of
    #   bestseller lists
    def bestseller_lists
      get_endpoint(Bestsellers::ListName.path).map{|l|
        Bestsellers::ListName.new(l)
      }
    end

    # Get a bestseller list
    # @param date [Date] The date of the list. Valid dates for a particular
    #   list can be retrieved by getting the 
    #   {Bestsellers::ListName#oldest} and {Bestsellers::ListName#newest}
    #   values from {#bestseller_lists}. 
    #
    #   You do not have to specify the exact date the list was published. The
    #   service will search forward (into the future) for the closest
    #   publication date to the date you specify. For example, retrieving the
    #   hardcover-nonfiction list for 2014-10-01 will retrieve the list that
    #   was published on 2014-10-05 (as can be determined from 
    #   {Bestsellers::List#published}
    #
    #   Requesting a list outside the retrievable date ranges will raise a
    #   {Kakutani::NoResultsError}
    # 
    # @param name [String] The name of the list. Valid names can be retrieved
    #   by getting the {Kakutani::Bestsellers::ListName#list_name_encoded} 
    #   values from {#bestseller_lists}.
    # @return [Bestsellers::List]
    # @raise [NoResultsError] if there are no results for the date of the 
    #   requested list
    # @example Checking the Publication Date of a List
    #   # Assuming c is a Client object
    #   > c.bestseller_list(Date.new(2014,10,1), 'hardcover-nonfiction').published.to_s
    #   => "2014-10-05"
    # 
    def bestseller_list(date, name)
      Bestsellers::List.new(get_endpoint(Bestsellers::List::path(date, name)))
    end

    def reviews(spec)
      revs = nil
      if spec.is_a?(Hash)
        if (spec.keys & [:isbn, :title, :author]).count > 0
          revs = reviews_by_hash(spec)
        else
          raise ParameterError.new(
            "No recognized parameter in #{spec.keys.join(', ')}"
          )
        end
      else
        revs = reviews_by_isbn(spec)
      end
 
      revs.map{|r| Bookreviews::Review.new(r)}
    end

    def reviews_by_isbn(isbn)
      # Thinking you can use an integer for an ISBN is an obvious mistake
      if ! isbn.is_a?(String)
        raise ParameterError.new(
          "Use a String, not #{isbn.class.name}, for an ISBN" 
        )
      end

      if isbn.downcase.gsub(/\-/, '') =~ /^([\da-z]{10}|[\da-z]{13})$/
        return reviews_by_hash({:isbn => isbn})
      end
      raise ParameterError.new "\"#{isbn}\" is not an ISBN"
    end

    def reviews_by_hash(spec)
      return get_endpoint(Bookreviews::Review::path, spec)
    end

    def get_endpoint(path, params={})
      params.merge!({'api-key' => @api_key})
      response = @conn.get endpoint(path), params
      if response.status == 200
        data = JSON.parse(response.body)
        if data['num_results'] > 0
          return data["results"]
        else
          raise Kakutani::NoResultsError.new "No results"
        end
      end
    end

    def endpoint(path)
      "#{path}.json"
    end
  end
end
