require "spec_helper"

describe Kakutani::Isbns do
  before :each do
    @full = Kakutani::Isbns.new("0425273865", "9780425273869")
    @no10 = Kakutani::Isbns.new("None", "9780425273869")
    @no13 = Kakutani::Isbns.new("0425273865", "None")
  end

  context "with both isbns" do
    it "should return the isbn10" do
      expect(@full.isbn10).to eq "0425273865"
    end

    it "should return the isbn13" do
      expect(@full.isbn13).to eq "9780425273869"
    end
  end

  context "with a missing isbn10" do
    it "should have a nil isbn10" do
      expect(@no10.isbn10).to be_nil
    end

    it "should return the isbn13" do
      expect(@no10.isbn13).to eq "9780425273869"
    end
  end

  context "with a missing isbn13" do
    it "should return the isbn10" do
      expect(@no13.isbn10).to eq "0425273865"
    end

    it "should have a nil isbn13" do
      expect(@no13.isbn13).to be_nil
    end
  end
end
