#
require "http/server"
require "./mime"
require "./routes"

class ApplicationHandler
  include HTTP::Handler

  def initialize
    @routes = Routes.new
  end

  def call(context : HTTP::Server::Context)
    begin
      context.response.reset
      if (context.request.method == "GET" )
        key = context.request.path
        context.response.content_type = Mime.get_type(key)
        context.response.puts(@routes.call_get(key))
      elsif (context.request.method == "DELETE" )
        context.response.puts(@routes.call_delete(context.request.path))
      end
    rescue KeyError
      call_next(context)
    end
  end

end

