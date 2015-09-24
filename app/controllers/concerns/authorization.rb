module Authorization
  extend ActiveSupport::Concern

  included do
    before_filter :set_euid_to_current_user
    after_filter :reset_euid
  end

  def set_euid_to_current_user
    Process.euid = Etc.getpwnam(current_username).uid
  end

  def reset_euid
    Process.euid = Process.uid
  end
end
