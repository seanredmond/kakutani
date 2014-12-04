require "spec_helper"

describe Kakutani::Client do
  before :each do
    @client = Kakutani::Client.new('fakeapikey')

    @response = double(Faraday::Response, :body => ISBN_1Q84, :headers => {},
                       :status => 200)

    allow_any_instance_of(Faraday::Connection).to receive(:get).
      and_return(@response)
  end

  describe "#reviews" do
    context "with an ISBN as the only parameter" do
      it "should make a request with the isbn URL" do
        expect_any_instance_of(Faraday::Connection)
          .to receive(:get)
          .with("/svc/books/v3/reviews/9781446484197.json", 
                instance_of(Hash))
          .and_return(@response)
        @client.reviews('9781446484197')
      end

      it "should call #reviews_by_isbn" do
        expect(@client).to receive(:reviews_by_isbn).with('9781446484197')
          .and_return({})
        @client.reviews('9781446484197')
      end

      it "should return an array" do
        expect(@client.reviews('9781446484197')).to be_an_instance_of(Array)
      end

      it "should return an array of Review objects" do
        expect(@client.reviews('9781446484197').first)
          .to be_an_instance_of(Kakutani::Review)
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
            .with("/svc/books/v3/reviews.json", 
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
end
