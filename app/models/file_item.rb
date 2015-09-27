require 'filemagic'

class FileItem < FilesystemItem
  def content
    read
  end

  def directory?
    false
  end

  def mime_type
    @mime_type ||= FileMagic.mime(FileMagic::MAGIC_SYMLINK).file full_path, :mime_type
  end

  def text?
    if File.file? full_path
      zero? || mime_type =~ /^(text\/.+)$/
    end
  end

  def editable?
    @editable ||= readable? and writable? and (!exist? || text?)
  end
end
