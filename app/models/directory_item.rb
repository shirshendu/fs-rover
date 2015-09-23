class DirectoryItem < FilesystemItem
  def listing
    Dir.entries full_path
  end

  def directory?
    true
  end

  def listable?
    readable? and executable?
  end
end
