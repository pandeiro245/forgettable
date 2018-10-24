class SessionsController < ApplicationController
  def create
    omniauth = request.env['omniauth.auth']
    if omniauth[:provider] == 'timecrowd'
      session[:timecrowd_token] = omniauth.credentials.token
    else
      session[:misoca_token] = omniauth.credentials.token
    end

    redirect_to root_path
  end
end
