#
require "http/server"

class Error404Handler
  include HTTP::Handler

  @content = "<html><body><img style=\"height:100%; width:auto; display:block; margin-left:auto; margin-right:auto;\" src=\"/error404\"></body></html>"
  
  def call(context : HTTP::Server::Context)
    begin
      context.response.reset
      context.response.status = HTTP::Status.new(404);
      context.response.content_type = "text/html";
      context.response.puts(@content)
    rescue Exception
      call_next(context)
    end
  end

end

