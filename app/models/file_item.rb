class FileItem < FilesystemItem
  def directory?
    false
  end

  def editable?
    readable? and writable?
  end
end
