class DirectoryItem < FilesystemItem
  def listing
    Dir.entries(full_path)
      .sort.map do |item|
      FilesystemItemFactory.create File.join(full_path, item), item
    end
  end

  def directory?
    true
  end

  def listable?
    readable? and executable?
  end
end
