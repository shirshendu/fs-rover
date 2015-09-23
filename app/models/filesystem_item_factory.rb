module FilesystemItemFactory
  def self.create(path, relative_path)
    full_path = File.expand_path path, '/'
    if File.directory? full_path
      DirectoryItem.new full_path, relative_path
    else
      FileItem.new full_path, relative_path
    end
  end
end
