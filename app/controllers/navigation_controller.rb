class NavigationController < ApplicationController
  include Authorization

  def show
    @path = params[:path] || '/'
    @fs_item = FilesystemItemFactory.create @path, @path
    if @fs_item.directory?
      dir_items = @fs_item.listing.sort.map{ |item| FilesystemItemFactory.create(File.join(@fs_item.full_path, item), item) }
      @listing = Kaminari.paginate_array(dir_items)
        .page(params[:page]).per(10)
    end
  end

  end
end
