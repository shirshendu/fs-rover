class NavigationController < ApplicationController
  before_filter :set_euid_to_current_user
  after_filter :reset_euid

  def show
    @path = params[:path] || '/'
    @fs_item = FilesystemItemFactory.create @path, @path
    if @fs_item.directory?
      dir_items = @fs_item.listing.sort.map{ |item| FilesystemItemFactory.create(File.join(@fs_item.full_path, item), item) }
      @listing = Kaminari.paginate_array(dir_items)
        .page(params[:page]).per(10)
    end
  end

  private
  def set_euid_to_current_user
    Process.euid = Etc.getpwnam(current_username).uid
  end

  def reset_euid
    Process.euid = Process.uid
  end
end
