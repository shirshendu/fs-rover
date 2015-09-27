class NavigationController < ApplicationController
  include Authorization
  include PathBreadcrumbs

  def show
    @path = params[:path] || Dir.home
    @fs_item = FilesystemItemFactory.create @path
    add_path_breadcrumbs @fs_item.dirname
    if @fs_item.directory?
      @listing = Kaminari.paginate_array(@fs_item.listing)
        .page(params[:page]).per(10)
      render :show_directory
    elsif @fs_item.file?
      if params[:download]
        send_file @fs_item.full_path, filename: @fs_item.basename
      else
        render :show_file
      end
    end
  end

  def edit
    @file = FileItem.new params[:path]
    unless @file.editable?
      redirect_to file_path, flash: { error: "#{params[:path]} is not an editable file" }
    end
  end

  def update
    @file = FileItem.new params[:file][:full_path], must_exist?: true
    @file.write params[:file][:content]
    redirect_to file_path(path: @file.dirname), flash: { success: "#{@file.full_path} successfully saved" }
  end

  def create
    @file = FileItem.new params[:file][:full_path]
    @file.content = params[:file][:content]
    redirect_to file_path(path: @file.dirname), flash: { success: "#{@file.full_path} successfully saved" }
  end
end
