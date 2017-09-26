class SessionsController < ApplicationController
  def index
  end

  def create
    session[:username] = request.env['omniauth.auth']['info']['name']
    redirect_to root_url
  end

  def destroy
    session.delete(:username)
    redirect_to root_url
  end
end
