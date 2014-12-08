require "spec_helper"

describe Kakutani::Client do
  before :each do
    @client = Kakutani::Client.new('fakeapikey')

    @response   = double(Faraday::Response, :body => ISBN_1Q84, :headers => {},
                       :status => 200)
    @lists      = double(Faraday::Response, :body => LIST_NAMES, :headers => {},
                       :status => 200)
    @list       = double(Faraday::Response, :body => TRADE_FIC, :headers => {},
                       :status => 200)
    @no_results = double(Faraday::Response, :body => NO_RESULT, :headers => {},
                       :status => 200)
    @search     = double(Faraday::Response, :body => SEARCH, :headers => {},
                       :status => 200)

    allow_any_instance_of(Faraday::Connection).to receive(:get).
      and_return(@response)
  end

  describe '#bestseller_lists' do
    before :each do
      allow_any_instance_of(Faraday::Connection).to receive(:get).
        and_return(@lists)
    end
      
    it "should make a request to the right endpoint" do
      expect_any_instance_of(Faraday::Connection)
        .to receive(:get)
        .with("http://api.nytimes.com/svc/books/v3/lists/names.json", 
              instance_of(Hash))
        .and_return(@lists)
      @client.bestseller_lists
    end

    it "should return an array" do
      expect(@client.bestseller_lists).to be_an_instance_of(Array)
    end

    it "should return an array of ListName objects" do
      expect(@client.bestseller_lists.first)
        .to be_an_instance_of(Kakutani::Bestsellers::ListName)
    end
  end

  describe "#bestseller_list" do
    before :each do
      allow_any_instance_of(Faraday::Connection).to receive(:get).
        and_return(@list)
    end
      
    it "should make a request to the right endpoint" do
      expect_any_instance_of(Faraday::Connection)
        .to receive(:get)
        .with("http://api.nytimes.com/svc/books/v3/lists/2014-12-01/trade-fiction-paperback.json", 
              instance_of(Hash))
        .and_return(@list)
      @client.bestseller_list('trade-fiction-paperback', Date.new(2014, 12, 1))
    end

    it "should return a List object" do
      expect(@client.bestseller_list(Date.new(2014, 12, 1), 
                                     'trade-fiction-paperback'))
        .to be_an_instance_of(Kakutani::Bestsellers::List)
    end
  end

  describe "#bestseller_search" do
    before :each do
      allow_any_instance_of(Faraday::Connection).to receive(:get).
        and_return(@search)
    end
    
    it "should make a request to the right endpoint" do
      expect_any_instance_of(Faraday::Connection)
        .to receive(:get)
        .with("http://api.nytimes.com/svc/books/v3/lists.json", 
              hash_including('list-name' => 'trade-fiction-paperback',
                             'isbn' => '9780425273869'))
        .and_return(@search)
      @client.bestsellers_search('trade-fiction-paperback', 
                              {'isbn' => '9780425273869'})
    end

    it "should return an Array" do
      expect(@client
               .bestsellers_search('trade-fiction-paperback', 
                                   {'isbn' => '9780425273869'})
             ).to be_an_instance_of(Array)
    end
  end

  describe "#reviews" do
    context "with an ISBN as the only parameter" do
      it "should make a request with the isbn URL" do
        expect_any_instance_of(Faraday::Connection)
          .to receive(:get)
          .with("http://api.nytimes.com/svc/books/v3/reviews.json", 
                hash_including(:isbn => '9781446484197'))
          .and_return(@response)
        @client.reviews('9781446484197')
      end

      it "should call #reviews_by_isbn" do
        expect(@client).to receive(:reviews_by_isbn).with('9781446484197')
          .and_return({})
        @client.reviews('9781446484197')
      end

      it "should call #reviews_by_hash" do
        expect(@client).to receive(:reviews_by_hash)
          .with(hash_including(:isbn => '9781446484197'))
          .and_return({})
        @client.reviews('9781446484197')
      end

      it "should return an array" do
        expect(@client.reviews('9781446484197')).to be_an_instance_of(Array)
      end

      it "should return an array of Review objects" do
        expect(@client.reviews('9781446484197').first)
          .to be_an_instance_of(Kakutani::Bookreviews::Review)
      end

      context "but passed as a number" do
        it "should raise a ParameterError" do
          expect{ @client.reviews(9781446484197) }
            .to raise_error(Kakutani::ParameterError)
        end
      end

      context "but one that doesn't match the ISBN pattern" do
        it "should raise a ParameterError" do
          expect{ @client.reviews('x9781446484197x') }
            .to raise_error(Kakutani::ParameterError)
        end
      end

    end

    context "with a hash as parameter" do
      context "with good parameters" do
        it "should call #reviews_by_hash" do
          expect(@client).to receive(:reviews_by_hash)
            .with(hash_including(:isbn => '12345', :title => 'title',
                                 :author => 'author'))
            .and_return({})
          @client.reviews({:isbn => '12345', :title => 'title',
                            :author => 'author'})
        end

        it "should make a request with the right parameters" do
          expect_any_instance_of(Faraday::Connection)
            .to receive(:get)
            .with("http://api.nytimes.com/svc/books/v3/reviews.json", 
                  hash_including(:isbn => '12345', :title => 'title',
                                 :author => 'author'))
            .and_return(@response)
          @client.reviews({:isbn => '12345', :title => 'title',
                            :author => 'author'})
        end
      end

      context "without any good parameter" do
        it "should raise a ParameterError" do
          expect{ @client.reviews({:bad => 'parameter'}) }
            .to raise_error(Kakutani::ParameterError)
        end
      end
    end
  end

  describe "#get_endpoint" do
    context "when there are no results" do
      it "Should raise a NoResultsError" do
        expect_any_instance_of(Faraday::Connection)
          .to receive(:get).and_return(@no_results)
        expect{
          @client.bestseller_list(Date.new(2014, 12, 1), 'hardcover-advice')
        }.to raise_error(Kakutani::NoResultsError)
      end
    end
  end
end
