class NavigationController < ApplicationController
  def show
    @path = params[:fspath]

  end
end
