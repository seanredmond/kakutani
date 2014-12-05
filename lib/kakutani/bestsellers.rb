module Kakutani
  module Bestsellers
    def self.path(sub)
      Kakutani::path(['lists', sub])
    end
  end
end
