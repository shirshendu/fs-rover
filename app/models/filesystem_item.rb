class FilesystemItem
  attr_accessor :full_path, :relative_path
  def initialize(path, rel_path)
    @full_path = path
    @relative_path = rel_path
  end

  def directory?
    @directory ||= File.directory? full_path
  end

  def readable?
    File.readable? full_path
  end

  def writable?
    File.writable? full_path
  end

  def executable?
    File.executable? full_path
  end
end
