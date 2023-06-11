require "spec"
require "../src/mime"

describe Mime do

  it "is txt" do
   Mime.get_type("/usr.txt").should eq("text/plain")
  end

  it "is html" do
   Mime.get_type("/url.html").should eq("text/html")
  end

  it "has no type" do
   Mime.get_type("/url").should eq("text/html")
  end

  it "has a unknown type" do
   Mime.get_type("/url.xxx").should eq("application/octet-stream")
  end

end

