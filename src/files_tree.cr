#
class FilesTree

  @json = ""

  def list(dirname)
    Dir.open(dirname) do |dir|
      dir.children.sort.each do |child|
        info = File.info "#{dirname}/#{child}"
        if info.directory?
          puts "Folder " + child
          @json += "{\"name\": \"" + child + "\", \"branches\": ["
          list("#{dirname}/#{child}")
          @json = @json.chomp(',') + "]},"
        else
          puts "File " + child
          @json += "{\"name\": \"" + child + "\"},"
        end
      end
    end
  end

#    puts "%-50s %10s %24s" % { child, info.size.format, info.modification_time }

  def get_json_tree(root)
    @json = "{\"name\": \"trunk\", \"branches\": ["
    list(root)
    @json.chomp(',') + "]}"
  end
  
end
