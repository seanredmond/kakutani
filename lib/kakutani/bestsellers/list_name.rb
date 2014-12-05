module Kakutani
  module Bestsellers   
    class ListName < Resource
      def self.path
        Bestsellers::path('names')
      end
    end
  end
end
