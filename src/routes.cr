#
require "./files_tree"

class Routes
  # @routes is a hash where key='method path'
  # the value is the content of the response sent to the client
  @routes = Hash(String, Proc(String)).new

  def initialize
    get "/robots.txt" do
      "User-agent: * Disallow: /"
    end
    get "/" do
      File.read("resources/index.html")
    end
    get "/favicon.ico" do
      File.read("resources/favicon32.png")
    end
    get "/style.css" do
      File.read("resources/style.css")
    end
    get "/treeview.js" do
      File.read("resources/treeview.js")
    end
    get "/files" do
      FilesTree.new.get_json_tree("files")
    end

  end

  def get(path : String, &block : -> String)
    @routes["GET "+path] = block
  end

  def get_call(key : String)
    @routes[key].call
  end

end

