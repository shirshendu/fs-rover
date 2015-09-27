module Authorization
  extend ActiveSupport::Concern

  included do
    before_filter :check_login
    before_filter :set_euid_to_current_user
    after_filter :reset_euid
    rescue_from FilesystemItem::Error, SystemCallError, with: :error
  end

  def user_signed_in?
    session[:username]
  end

  def check_login
    redirect_to login_path, flash: { error: 'You are not logged in' } unless user_signed_in?
  end

  def set_euid_to_current_user
    Process.euid = Etc.getpwnam(current_username).uid
  end

  def reset_euid
    puts 'euid reset'
    Process.euid = Process.uid
  end

  def error(e)
    reset_euid
    redirect_to file_path(path: Dir.home), flash: { error: e.message }
  end
end
