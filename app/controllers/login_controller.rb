require 'rpam'

class LoginController < ApplicationController
  def new
    redirect_to file_path if current_username
  end

  def create
    credentials = params[:login]
    if credentials[:username] == 'root' && !Rails.configuration.allow_root_login
      @success = false
    else
      @success = Rpam.auth(credentials[:username], credentials[:password])
    end
    if @success
      session[:username] = credentials[:username]
      flash[:success] = 'Welcome to the FileSystem Rover'
      redirect_to file_path(path: Dir.home)
    else
      flash[:error] = 'Login failed'
      redirect_to login_path
    end
  end

  def destroy
    session.delete :username
    redirect_to login_path
  end
end
