require 'rpam'

class LoginController < ApplicationController
  def new
  end

  def create
    credentials = params[:login]
    @success = Rpam.auth(credentials[:username], credentials[:password])
    if @success
      session[:username] = credentials[:username]
      flash[:success] = 'Welcome to the FileSystem Rover'
      redirect_to navigation_path path: Dir.home
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
