require "spec_helper"

describe Kakutani::Bestsellers::AgeGroup do
  context "with lower and upper bounds" do
    before :each do
      @age = Kakutani::Bestsellers::AgeGroup.new({"age_group" => "Ages 4 to 10"})
    end

    describe "#age_group" do
      it "should have the right label" do
        expect(@age.age_group).to eq "Ages 4 to 10"
      end
    end

    describe "#min" do
      it "should be a number" do
        expect(@age.min).to be_an_instance_of Fixnum
      end

      it "should have a lower bound" do
        expect(@age.min).to eq 4
      end
    end
    
    describe "#max" do
      it "should be a number" do
        expect(@age.max).to be_an_instance_of Fixnum
      end

      it "should have an upper bound" do
        expect(@age.max).to eq 10
      end
    end
  end

  context "with no upper bounds" do
    before :each do
      @age = Kakutani::Bestsellers::AgeGroup.new({"age_group" => "Ages 4 and up"})
    end

    describe "#age_group" do
      it "should have the right label" do
        expect(@age.age_group).to eq "Ages 4 and up"
      end
    end

    describe "#min" do
      it "should be a number" do
        expect(@age.min).to be_an_instance_of Fixnum
      end

      it "should have a lower bound" do
        expect(@age.min).to eq 4
      end
    end
    
    describe "#max" do
      it "should not have an upper bound" do
        expect(@age.max).to be_nil
      end
    end
  end

  context "with 'All ages'" do
    before :each do
      @age = Kakutani::Bestsellers::AgeGroup.new({"age_group" => "All ages"})
    end

    describe "#age_group" do
      it "should have the right label" do
        expect(@age.age_group).to eq "All ages"
      end
    end

    describe "#min" do
      it "should not have a lower bound" do
        expect(@age.min).to be_nil
      end
    end
    
    describe "#max" do
      it "should not have an upper bound" do
        expect(@age.max).to be_nil
      end
    end
  end
end
