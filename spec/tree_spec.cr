#
require "spec"
require "../src/tree"

describe Tree do

  expected = "{\"name\": \"\", \"branches\": [{\"name\": \"empty.txt\", \"size\": \"0\"},{\"name\": \"file.txt\", \"size\": \"10\"}]}"

  it "works" do
    Tree.get_json("./spec/resources").should eq(expected)
  end

end

