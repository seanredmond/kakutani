module Kakutani
  class Client
    @@server = 'http://api.nytimes.com'
    @@base_uri = '/svc/books/v3'

    def initialize(api_key)
      @api_key = api_key
      @conn = Faraday.new(:url => @@server)
    end

    def reviews(spec)
      if spec.is_a?(Hash)
        return reviews_by_isbn(spec[:isbn]) if spec.has_key?(:isbn)
      end
      reviews_by_isbn(spec)
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
