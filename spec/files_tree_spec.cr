#
require "spec"
require "../src/files_tree"

describe FilesTree do

  expected = "{\"name\": \"trunk\", \"branches\": [{\"name\": \"files_tree_spec.cr\"},{\"name\": \"mime_spec.cr\"},{\"name\": \"resources\", \"branches\": [{\"name\": \"file.txt\"}]},{\"name\": \"routes_spec.cr\"}]}"
  it "works" do
    FilesTree.new.get_json_tree("./spec").should eq(expected)
  end

end

