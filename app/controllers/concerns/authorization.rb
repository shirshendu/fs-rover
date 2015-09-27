module Authorization
  extend ActiveSupport::Concern

  included do
    before_filter :check_login
    before_filter :set_euid_to_current_user
    after_filter :reset_euid
    rescue_from FilesystemItem::Error, SystemCallError, with: :fs_error_handler
    rescue_from StandardError, with: :error_handler
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
    Process.euid = Process.uid
  end

  def fs_error_handler(e)
    reset_euid
    redirect_to file_path(path: Dir.home), flash: { error: e.message }
  end

  def error_handler(e)
    reset_euid
    session.delete :username
    redirect_to login_path, flash: { error: e.message + '- As a security measure, you have been logged out' }
  end
end
