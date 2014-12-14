require "spec_helper"

describe Kakutani::Bestsellers::Overview do
  before :each do
    @overv = Kakutani::Bestsellers::Overview.new(JSON.parse(OVERVW)['results'])
  end

  describe "#lists" do
    it "should have return a Hash" do
      expect(@overv.lists).to be_an_instance_of(Hash)
    end

    it "should be an Hash with List objects as values" do
      expect(@overv.lists['Combined Print and E-Book Fiction'])
        .to be_an_instance_of(Kakutani::Bestsellers::List)
    end
  end
end
