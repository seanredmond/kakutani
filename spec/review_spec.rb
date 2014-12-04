require "spec_helper"

describe Kakutani::Review do
  before :each do
    @review = Kakutani::Review.new(JSON.parse(ISBN_1Q84)['results'].first)
  end

  describe "basic properties" do
    it "has #url" do
      expect(@review.url).to eq "http://www.nytimes.com/2011/11/10/books/1q84-by-haruki-murakami-review.html"
    end

    it "has #byline" do
      expect(@review.byline).to eq "JANET MASLIN"
    end

    it "has #book_title" do
      expect(@review.book_title).to eq "1Q84"
    end

    it "has #book_author" do
      expect(@review.book_author).to eq "Haruki Murakami"
    end

    it "has #summary" do
      expect(@review.summary).to start_with "In \u201c1Q84,\u201d the"
    end
    
  end

  describe "#published" do
    it "returns a date" do
      expect(@review.published).to be_an_instance_of(Date)
    end

    it "returns to date of publication" do
      expect(@review.published.to_s).to eq "2011-11-10"
    end
  end

  describe "isbns" do
    it "returns an array" do
      expect(@review.isbns).to be_an_instance_of(Array)
    end

    it "returns the isbns" do
      expect(@review.isbns.first).to eq "9781446484203"
    end
  end

  describe "#parse_date" do
    it "converts JSON time to correct Date" do
      expect(@review.parse_date("2011-11-10 00:00:00")).to eq Date.new(2011,11,10)
    end

    it "returns nil when given a bad date" do
      expect(@review.parse_date("0000-00-00 00:00:00")).to be_nil
    end
  end
end
