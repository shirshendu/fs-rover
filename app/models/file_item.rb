require 'filemagic'

class FileItem < FilesystemItem
  def directory?
    false
  end

  def mime_type
    @mime_type ||= FileMagic.mime.file full_path, :mime_type
  end

  def text?
    if File.file? full_path
      mime_type =~ /^(inode\/x-empty)|(text\/.+)$/
    end
  end

  def editable?
    readable? and writable?
  end
end
