require 'spec_helper'

describe Converge::Engine do
  rules do
    redirect({path: "/secure", scheme: "http"}, {scheme: "https"})
    redirect({path: /^\/$/, scheme: "https"}, {scheme: "http"})
  end

  it "matches and rewrites URI components" do
    request("http://example.com/whatever") do |response|
      response.should_not be_rewritten
      response.match.should be_nil
    end
  end

  it "returns the matched rule" do
    request("http://example.com/secure") do |response|
      response.match.should == rules.first
    end
  end

  request("http://example.com/secure") { should redirect_to("https://example.com/secure").with(301) }
  request("https://example.com/") { should redirect_to("http://example.com/").with(301) }
end