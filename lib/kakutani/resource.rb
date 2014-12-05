module Kakutani
  class Resource
    def initialize(data, client=nil)
      @data = data
      @client = client
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
