require 'spec_helper'

describe Converge::Engine do
  rules do
    redirect({path: "/secure", scheme: "http"}, {scheme: "https"})
    redirect({path: /^\/$/, scheme: "https"}, {scheme: "http"})
  end

  it "matches and rewrites URI components" do
    request("http://example.com/whatever") do |response|
      response.should_not be_rewritten
    end

    request("http://example.com/secure") do |response|
      response.headers["Location"].should == "https://example.com/secure"
    end

    request("https://example.com/") do |response|
      response.headers["Location"].should == "http://example.com/"
    end
  end
end