#
require "http/server"
require "./mime"
require "./request/delete"
require "./request/get"

class ApplicationHandler
  include HTTP::Handler

  def initialize
    @routes = Get.new
  end

  def call(context : HTTP::Server::Context)
    begin
      context.response.reset
      if (context.request.method == "GET" )
        key = context.request.path
        context.response.content_type = Mime.get_type(key)
        context.response.puts(@routes.call_get(key, context.request.query))
      elsif (context.request.method == "DELETE" )
        context.response.puts(Delete.file(context.request.path))
      end
    rescue KeyError
      call_next(context)
    end
  end

end

