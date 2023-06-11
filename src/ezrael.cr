#
VERSION = "0.1.0"

require "http/server"
require "./application_handler.cr"
require "./error404_handler.cr"

puts "Ezrael version " + VERSION

# HTTP::Handler(s)
log      = HTTP::LogHandler.new
error    = HTTP::ErrorHandler.new
notfound = Error404Handler.new
appli    = ApplicationHandler.new
#static = HTTP::StaticFileHandler.new(File.expand_path("."))
#handlers = [ log, error, appli, static ]
handlers = [ log, appli, notfound, error ]

server = HTTP::Server.new(handlers)
address = server.bind_tcp 8080
puts "Listening on http://#{address}"
puts "Use Ctrl-C to stop"
server.listen

