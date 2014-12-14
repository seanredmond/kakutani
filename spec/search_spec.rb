require "spec_helper"

describe Kakutani::Bestsellers::Search do
  before :each do
    @search = Kakutani::Bestsellers::Search.new(JSON.parse(SEARCH)['results'].first)
  end

  describe "#book_details" do
    it "should be an Array" do
      expect(@search.book_details).to be_an_instance_of(Array)
    end
      
    it "should be an Array BookDetails objects" do
      expect(@search.book_details.first)
        .to be_an_instance_of(Kakutani::Bestsellers::BookDetails)
    end
  end
end
