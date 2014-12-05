module Kakutani
  module Bestsellers   
    class List < Resource
      def initialize(data)
        super(data)
      end

      def self.path(date, name)
        Bestsellers::path([date.to_s, name])
      end
    end
  end
end
