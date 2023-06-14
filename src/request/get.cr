#
require "../tree"

class Get
  # @routes is a hash where key='method path'
  # the value is the content of the response sent to the client
  @routes = Hash(String, Proc(String)).new
  @query = Nil

  def initialize
    get "/robots.txt" do
      "User-agent: * Disallow: /"
    end
    get "/" do
      File.read("resources/index.html").sub("VERSION", VERSION)
    end
    get "/favicon.ico" do
      File.read("resources/favicon32.png")
    end
    get "/style.css" do
      File.read("resources/style.css")
    end
    get "/clock.js" do
      File.read("resources/clock.js")
    end
    get "/treeview.js" do
      File.read("resources/treeview.js")
    end
    get "/files" do
      Tree.get_json("files")
    end
    get "/error404" do
      File.read("resources/houston404.png")
    end
    get "/download" do
      "download"
    end
  end

  def get(path : String, &block : -> String)
    @routes[path] = block
  end

  def call_get(key : String, query : String | Nil)
    @query = query
    @routes[key].call
  end

end

