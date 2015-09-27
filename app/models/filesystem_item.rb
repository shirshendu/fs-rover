class FilesystemItem
  attr_accessor :full_path, :relative_path
  def initialize(path, opts={must_exist?: false, rel_path: nil})
    @full_path = path
    validate_existence if opts[:must_exist?]
    @relative_path = opts[:rel_path] || path
  end

  def method_missing m, *args, &block
    File.public_send m, full_path, *args, &block
  end

  def validate_existence
    raise NotFoundError, 'No such file or directory: ' + full_path unless exist?
  end

  class Error < StandardError; end
  class NotFoundError < Error; end
end
