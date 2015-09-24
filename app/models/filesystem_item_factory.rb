module FilesystemItemFactory
  def self.create(path, relative_path=nil)
    full_path = File.expand_path path, '/'
    relative_path ||= full_path
    if File.directory? full_path
      DirectoryItem.new full_path, relative_path
    elsif File.exist? full_path
      FileItem.new full_path, relative_path
    end
  end
end
