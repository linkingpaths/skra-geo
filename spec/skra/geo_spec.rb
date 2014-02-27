require 'spec_helper'

describe Skra::Geo do
  it 'should have a version number' do
    Skra::Geo::VERSION.should_not be_nil
  end


  describe "search based on landnr" do
    it "should return the feature for that landnr (Parcel ID)" do
      results = Skra::Geo.landnr(100404)
      results[0]["properties"]["LANDNR"].should == 100404
      results[0]["properties"]["HEITI_NF"].should == "Holtsgata"
    end
  end

  describe "search based on heinum" do
    it "should return the feature for that heinum (Property ID)" do
      results = Skra::Geo.heinum(1008773)
      results.size.should == 1
      results[0]["properties"]["HEINUM"].should == 1008773
      results[0]["properties"]["HEITI_NF"].should == "Holtsgata"
    end
  end

  describe "search based on a street" do

    it "should return features for all streets in Iceland with that name" do
      results = Skra::Geo.street('Holtsgata')
      results.size.should > 1
      results.map{|result| result["properties"]["POSTNR"]}.should include(101)
    end

    it "should return features for all streets in Iceland using a name in dative" do
      results = Skra::Geo.street('Holtsgötu', nil, nil, {:dative => true})
      results.size.should > 1
      results.map{|result| result["properties"]["POSTNR"]}.should include(101)
    end

    it "should return features for a given street+number" do
      results = Skra::Geo.street('Holtsgata', 13)
      results.size.should > 1
    end

    it "should return features for a given street+number+postcode" do
      results = Skra::Geo.street('Holtsgata', 13, 101)
      results.size.should == 1
      results[0]["properties"]["HEINUM"].should == 1008773
    end
  end

end