require "spec"
require "../src/request/get"
require "../src/version.cr"

describe Get do

  it "works" do
    Get.new.get_call("GET /robots.txt").should eq("User-agent: * Disallow: /")
  end

end
