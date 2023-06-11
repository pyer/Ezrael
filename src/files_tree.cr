#
class FilesTree

  @json = ""

  def list(dir)
    Dir.each(dir) { |x|
      unless x.starts_with?(".")
        if File.directory?(x)
          @json += "{\"" + x + "\":["
          list(dir + "/" + x)
          @json = @json.chomp(',') + "]},"
        else
          @json += "\"" + x + "\","
        end
      end
    }
  end

  def get_json_tree(root)
    @json = "{\"files\": ["
    list(root)
    @json.chomp(',') + "]}"
  end
  
end

