module Kakutani
  module Bestsellers
    def self.path(sub=nil)
      return Kakutani::path(['lists']) if sub.nil?
      return Kakutani::path(['lists', sub])
    end
  end
end
