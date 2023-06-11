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
      key = context.request.method+" "+context.request.path
      context.response.reset
      context.response.content_type = Mime.get_type(key)
      context.response.puts(@routes.get_call(key))
    rescue KeyError
      call_next(context)
    end
  end

end

