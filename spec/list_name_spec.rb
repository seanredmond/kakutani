require "spec_helper"

describe Kakutani::Bestsellers::ListName do
  before :each do
    @list = Kakutani::Bestsellers::ListName.new(JSON.parse(LIST_NAMES)['results'].first)
  end

  describe "#oldest" do
    it "should be a Date" do
      expect(@list.oldest).to be_an_instance_of Date
    end

    it "should be the correct date" do
      expect(@list.oldest).to eq Date.new(2011, 2, 13)
    end
  end

  describe "#newest" do
    it "should be a Date" do
      expect(@list.newest).to be_an_instance_of Date
    end

    it "should be the correct date" do
      expect(@list.newest).to eq Date.new(2014, 12, 7)
    end
  end

  describe "basic properties" do
    it "has #display_name" do
      expect(@list.display_name).to eq "Combined Print & E-Book Fiction"
    end

    it "has #list_name" do
      expect(@list.list_name).to eq "Combined Print and E-Book Fiction"
    end

    it "has #list_name_encoded" do
      expect(@list.list_name_encoded).to eq "combined-print-and-e-book-fiction"
    end

    it "has #newest_published_date" do
      expect(@list.newest_published_date).to eq "2014-12-07"
    end

    it "has #oldest_published_date" do
      expect(@list.oldest_published_date).to eq "2011-02-13"
    end

    it "has #updated" do
      expect(@list.updated).to eq "WEEKLY"
    end
  end
end

