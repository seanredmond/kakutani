module Kakutani
  class Client
    @@server = 'http://api.nytimes.com'
    @@base_uri = '/svc/books/v3'

    def initialize(api_key)
      @api_key = api_key
      @conn = Faraday.new(:url => @@server)
    end

    def reviews(spec)
      revs = nil
      if spec.is_a?(Hash)
        if spec.has_key?(:isbn)
          revs = reviews_by_isbn(spec[:isbn]) 
        elsif spec.has_key?(:title)
          revs = reviews_by_title(spec[:title])
        else
          raise ParameterError.new(
            "No recognized parameter in #{spec.keys.join(', ')}"
          )
        end
      else
        revs = reviews_by_isbn(spec)
      end
 
      revs.map{|r| Kakutani::Review.new(r)}
    end

    def reviews_by_isbn(isbn)
      # Thinking you can use an integer for an ISBN is an obvious mistake
      if ! isbn.is_a?(String)
        raise ParameterError.new(
          "Use a String, not #{isbn.class.name}, for an ISBN" 
        )
      end

      if isbn.gsub(/\-/, '') =~ /^(\d{10}|\d{13})$/
        return get_endpoint("reviews/#{isbn}")
      end
      raise ParameterError.new "\"#{isbn}\" is not an ISBN"
    end

    def reviews_by_title(title)
      return get_endpoint("reviews", {:title => title})
    end

    def get_endpoint(path, params={})
      params.merge!({'api-key' => @api_key})
      response = @conn.get endpoint(path), params
      return JSON.parse(response.body)["results"] if response.status == 200
    end

    def endpoint(path)
      "#{@@base_uri}/#{path}.json"
    end
  end
end
