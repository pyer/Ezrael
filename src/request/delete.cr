#
class Delete

  def self.file(path : String)
    File.delete("."+path)
  end

end

