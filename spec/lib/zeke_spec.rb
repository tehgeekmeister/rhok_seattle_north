require 'spec_helper'

describe Zeke do

  # cache search on major U.S. city
  result = Zeke.search("denver")

  it ( "We return more than zero results") do
    assert result.toponyms.empty?.should be_false
  end

  it ( "First place is feature_class of P " ) do
    assert (result.toponyms[0].feature_class == "P").should be_true
  end

  it("Empty string passed in as placename") do
    assert (Zeke.search("").total_results_count == "0").should be_true
  end

  it("Non text string passed in as placename") do
    assert (Zeke.search("|").total_results_count == "0").should be_true
  end

  it("Garbage string passed in as placename") do
    assert (Zeke.search("jkasdgfkjasdgfkjhasdgfkj").total_results_count == "0").should be_true
  end

  it("Nearby placename is included in results") do
    assert result.toponyms.collect { |foo| foo.name }.include?("Town of Denver").should be_true
  end
end
