class NavigationController < ApplicationController
  before_filter :set_euid_to_current_user
  after_filter :reset_euid

  def show
    @path = params[:fspath]

  private
  def set_euid_to_current_user
    Process.euid = Etc.getpwnam(current_username).uid
  end

  def reset_euid
    Process.euid = Process.uid
  end
end
