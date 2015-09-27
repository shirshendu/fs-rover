module PathBreadcrumbs
  extend ActiveSupport::Concerns
  def add_path_breadcrumbs(full_path)
    add_breadcrumb '/', file_path(path: '/')
    path = '/'
    Pathname.new(full_path).each_filename do |filename|
      path << (filename + '/')
      add_breadcrumb filename, file_path(path: path)
    end
  end
end
