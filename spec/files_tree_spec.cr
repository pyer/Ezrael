#
require "spec"
require "../src/files_tree"

describe FilesTree do

  it "works" do
    FilesTree.new.get_json_tree("./spec").should eq("{\"files\": [\"files_tree_spec.cr\",\"routes_spec.cr\",{\"resources\":[\"file.txt\"]},\"mime_spec.cr\"]}")
  end

end

