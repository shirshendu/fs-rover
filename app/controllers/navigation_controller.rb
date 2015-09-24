class NavigationController < ApplicationController
  include Authorization

  def show
    @path = params[:path] || '/'
    @fs_item = FilesystemItemFactory.create @path
    if @fs_item.directory?
      @listing = Kaminari.paginate_array(@fs_item.listing)
        .page(params[:page]).per(10)
    end
  end

  end
end
