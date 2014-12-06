module Kakutani
  module Bestsellers   
    class List < Resource
      attr_reader :date, :published, :name
      def initialize(data)
        super(data)
        @date = Date.strptime(bestsellers_date)
        @published = Date.strptime(published_date)
        @name = list_name
      end

      def self.path(date, name)
        Bestsellers::path([date.to_s, name])
      end
    end
  end
end
