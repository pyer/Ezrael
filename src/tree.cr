#
class Tree

  @@json = ""

  def self.list(dirname)
    Dir.open(dirname) do |dir|
      dir.children.sort.each do |child|
        info = File.info "#{dirname}/#{child}"
        if info.directory?
          @@json += "{\"name\": \"" + child + "\", \"branches\": ["
          list("#{dirname}/#{child}")
          @@json = @@json.chomp(',') + "]},"
        else
          @@json += "{\"name\": \"" + child + "\", \"size\": \"" + info.size.to_s + "\"},"
        end
      end
    end
  end

#    puts "%-50s %10s %24s" % { child, info.size.format, info.modification_time }

  def self.get_json(root)
    @@json = "{\"name\": \"\", \"branches\": ["
    list(root)
    @@json.chomp(',') + "]}"
  end
  
end
