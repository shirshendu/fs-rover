class FilesystemItem
  attr_accessor :full_path, :relative_path
  def initialize(path, rel_path=nil)
    @full_path = path
    @relative_path = rel_path || path
  end

  def method_missing m, *args, &block
    File.public_send m, full_path, *args, &block
  end
end
