require "spec_helper"

describe Kakutani::Bestsellers::List do
  before :each do
    @list = Kakutani::Bestsellers::List.new(JSON.parse(TRADE_FIC)['results'])
  end

  describe "#date" do
    it "is a Date" do
      expect(@list.date).to be_an_instance_of Date
    end

    it "is the right date" do
      expect(@list.date).to eq Date.new(2014, 11, 22)
    end
  end

  describe "#published" do
    it "is a Date" do
      expect(@list.published).to be_an_instance_of Date
    end

    it "is the right date" do
      expect(@list.published).to eq Date.new(2014, 12, 7)
    end
  end

  describe "#books" do
    it "is an Array" do
      expect(@list.books).to be_an_instance_of Array
    end

    it "is an Array of Title objects" do
      expect(@list.books.first).to be_an_instance_of(Kakutani::Bestsellers::Title)
    end
  end

  describe "#corrections" do
    it "is an Array" do
      expect(@list.corrections).to be_an_instance_of Array
    end
  end

  describe "basic properties" do
    it "has #name" do
      expect(@list.name).to eq "Trade Fiction Paperback"
    end

    it "has #display_name" do
      expect(@list.display_name).to eq "Paperback Trade Fiction"
    end

    it "has #normal_list_ends_at" do
      expect(@list.normal_list_ends_at).to eq 10
    end

    it "has #updated" do
      expect(@list.updated).to eq "WEEKLY"
    end
  end
end
