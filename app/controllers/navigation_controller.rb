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

  def edit
    @file = FileItem.new params[:path]
    redirect_to(:back) && return unless @file.editable?
  end
end
