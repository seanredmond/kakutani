module Kakutani
  class Review
    attr_reader :published, :isbns

    def initialize(data)
      @data = data
      @published = DateTime
        .strptime(data['publication_dt'], '%Y-%m-%d %H:%M:%S').to_date
      @isbns = data['isbn13']
    end

    # Any property of the resource present in the JSON response can be accessed
    # by name in the Resource instance.
    def method_missing name, *args
      name = name.to_s
      if args.empty? && @data.keys.include?(name)
        return @data[name]
      end
      raise NoMethodError, "undefined method `#{name}' for #{self}"
    end
  end
end
