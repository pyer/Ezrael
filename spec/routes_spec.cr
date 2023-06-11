require "spec"
require "../src/routes"
require "../src/version.cr"

describe Routes do

  it "works" do
    Routes.new.get_call("GET /robots.txt").should eq("User-agent: * Disallow: /")
  end

end
