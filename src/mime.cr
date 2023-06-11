#

class Mime 
  # get a mime from file extension
  TYPE = {
    ".html" =>  "text/html",
    ".css"  =>  "text/css",
    ".txt"  =>  "text/plain",
    ".gif"  =>  "image/gif",
    ".jpeg" =>  "image/jpeg",
    ".jpg"  =>  "image/jpeg",
    ".png"  =>  "image/png",
    ".ico"  =>  "image/vnd.microsoft.icon",
    ".js"   =>  "application/javascript",
    ".json" =>  "application/json"
  }

  def self.get_type(req : String)
    dot = req.rindex('.')
    return "text/html" if dot.nil?
    len = req.size
    ext = req[dot, len]
    begin
      mime = TYPE[ext]
    rescue KeyError
      mime = "application/octet-stream"
    end
    return mime
  end

end

