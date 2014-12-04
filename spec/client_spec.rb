require "spec_helper"

describe Kakutani::Client do
  before :each do
    @client = Kakutani::Client.new('fakeapikey')

    # Monkey-patch Client object so we can mock the connection
    def @client.conn=(c)
      @conn = c
    end

    def @client.conn
      @conn
    end
  end

  describe "#reviews" do
    context "with an ISBN as the only parameter" do
      before :each do
        @r = double(Faraday::Response, :body => ISBN_1Q84, :headers => {},
                    :status => 200)
        allow_any_instance_of(Faraday::Connection).to receive(:get).
          and_return(@r)
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
        before :each do
          @r = double(Faraday::Response, :body => ISBN_1Q84, :headers => {},
                      :status => 500)
          allow_any_instance_of(Faraday::Connection).to receive(:get).
            and_return(@r)
        end

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
      end

      context "including :title" do
        before :each do
          @r = double(Faraday::Response, :body => ISBN_1Q84, :headers => {},
                      :status => 500)
          allow_any_instance_of(Faraday::Connection).to receive(:get).
            and_return(@r)
        end

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
