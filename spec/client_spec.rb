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
      context "including :isbn" do
        it "should call #reviews_by_isbn" do
          expect(@client).to receive(:reviews_by_isbn).with('9781446484197')
            .and_return({})
          @client.reviews({:isbn => '9781446484197'})
        end

        it "should use :isbn over other parameters" do
          expect(@client).to receive(:reviews_by_isbn).with('9781446484197')
            .and_return({})

          @client.reviews({:isbn => '9781446484197', :title => '1Q84'})
        end

        it "should make a request with the isbn URL" do
          expect_any_instance_of(Faraday::Connection)
            .to receive(:get)
            .with("/svc/books/v3/reviews/9781446484197.json", 
                  instance_of(Hash))
            .and_return(@response)
          @client.reviews({:isbn => '9781446484197'})
        end
      end

      context "including :title" do
        it "should call #reviews_by_title" do
          expect(@client).to receive(:reviews_by_title).with('Gone Girl')
            .and_return({})
          @client.reviews({:title => 'Gone Girl'})
        end

        it "should use :title over :author" do
          expect(@client).to receive(:reviews_by_title).with('Gone Girl')
            .and_return({})
          @client.reviews({:title => 'Gone Girl', :author => 'Gillian Flynn'})
        end

        it "should make a request with the title parameter" do
          expect_any_instance_of(Faraday::Connection)
            .to receive(:get)
            .with("/svc/books/v3/reviews.json",
                  hash_including(:title => 'Gone Girl'))
            .and_return(@response)
          @client.reviews({:title => 'Gone Girl'})
        end
      end

      context "including :author" do
        it "should call #reviews_by_author" do
          expect(@client).to receive(:reviews_by_author)
            .with('Haruki Murakami')
            .and_return({})
          @client.reviews({:author => 'Haruki Murakami'})
        end

        it "should make a request with the author parameter" do
          expect_any_instance_of(Faraday::Connection)
            .to receive(:get)
            .with("/svc/books/v3/reviews.json",
                  hash_including(:author => 'Haruki Murakami'))
            .and_return(@response)
          @client.reviews({:author => 'Haruki Murakami'})
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
