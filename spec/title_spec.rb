require "spec_helper"

describe Kakutani::Bestsellers::Title do
  before :each do
    @title = Kakutani::Bestsellers::Title.new(JSON.parse(BOOK))
  end

  describe "#rank" do
    it "is a number" do
      expect(@title.rank).to be_an_instance_of Fixnum
    end

    it "has the right rank" do
      expect(@title.rank).to eq 1
    end
  end

  describe "#rank_last_week" do
    it "is a number" do
      expect(@title.rank_last_week).to be_an_instance_of Fixnum
    end

    it "has the right rank" do
      expect(@title.rank_last_week).to eq 0
    end
  end

  describe "#ranked_previous_week?" do
    context "with book not on previous list" do
      it "returns false" do
        expect(@title.ranked_previous_week?).to eq false
      end
    end

    context "with book on previous list" do
      before :each do
        @ranked = Kakutani::Bestsellers::Title.new(JSON.parse(GG_LIST))
      end

      it "returns true" do
        expect(@ranked.ranked_previous_week?).to eq true
      end
    end
  end

  describe "#weeks_on_list" do
    it "is a number" do
      expect(@title.weeks_on_list).to be_an_instance_of Fixnum
    end

    it "returns the right number" do
      expect(@title.weeks_on_list).to eq 1
    end
  end

  describe "#asterisk?" do
    context "with a book without an asterisk" do
      it "should return false" do
        expect(@title.asterisk?).to eq false
      end
    end

    context "with a book with an asterisk" do
      before :each do
        @asterisked = Kakutani::Bestsellers::Title.new(JSON.parse(FB_LIST))
      end

      it "should return true" do
        expect(@asterisked.asterisk?).to eq true
      end
    end
  end

  describe "#dagger?" do
    context "with a book without a dagger" do
      it "should return false" do
        expect(@title.dagger?).to eq false
      end
    end

    context "with a book with a dagger" do
      before :each do
        @daggered = Kakutani::Bestsellers::Title.new(JSON.parse(TK_LIST))
      end

      it "should return true" do
        expect(@daggered.dagger?).to eq true
      end
    end
  end

  describe "#primary_isbns" do
    it "returns an Isbns object" do
      expect(@title.primary_isbns).to be_an_instance_of(Kakutani::Isbns)
    end

    it "returns the right ISBN10" do
      expect(@title.primary_isbns.isbn10).to eq "0425273865"
    end
      
    it "returns the right ISBN13" do
      expect(@title.primary_isbns.isbn13).to eq "9780425273869"
    end
  end

  describe "#publisher" do
    it "has a publisher" do
      expect(@title.publisher).to eq "Berkley"
    end
  end

  describe "#description" do
    it "has a description" do
      expect(@title.description).to start_with "Eva and Gideon's vows"
    end
  end

  describe "#price" do
    before :each do
      @priced = Kakutani::Bestsellers::Title.new(JSON.parse(OUTL_LIST))
    end
   
    it "is a float" do
      expect(@priced.price).to be_an_instance_of Float
    end

    it "has the right price" do
      expect(@priced.price).to eq 16.99
    end
  end

  describe "#title" do
    it "has a title" do
      expect(@title.title).to eq "CAPTIVATED BY YOU"
    end
  end

  describe "#author" do
    it "has a author" do
      expect(@title.author).to eq "Sylvia Day"
    end
  end

  describe "#contributor" do
    it "has a contributor" do
      expect(@title.contributor).to eq "by Sylvia Day"
    end
  end

  describe "#contributor_note" do
    it "has a contributor_note" do
      expect(@title.contributor_note).to eq ""
    end
  end

  describe "#book_image" do
    it "has a book_image" do
      expect(@title.book_image).to eq "http://du.ec2.nytimes.com.s3.amazonaws.com/prd/books/9780698153462.jpg"
    end
  end

  describe "#amazon_product_url" do
    it "has an amazon_product_url" do
      expect(@title.amazon_product_url).to eq "http://www.amazon.com/Captivated-By-You-Crossfire-Novel/dp/0425273865?tag=thenewyorktim-20"
    end
  end

  describe "#age_group" do
    it "has an age_group" do
      expect(@title.age_group).to eq ""
    end
  end

  describe "#book_review_link" do
    it "has a book_review_link" do
      expect(@title.book_review_link).to eq ""
    end
  end

  describe "#first_chapter_link" do
    it "has a first_chapter_link" do
      expect(@title.first_chapter_link).to eq ""
    end
  end

  describe "#sunday_review_link" do
    it "has a sunday_review_link" do
      expect(@title.sunday_review_link).to eq ""
    end
  end

  describe "#article_chapter_link" do
    it "has an article_chapter_link" do
      expect(@title.article_chapter_link).to eq ""
    end
  end

  describe "#isbns" do
    it "returns an array" do
      expect(@title.isbns).to be_an_instance_of Array
    end

    it "returns an array of Isbns" do
      expect(@title.isbns.first).to be_an_instance_of Kakutani::Isbns
    end
  end
end

