class UsersController < ApplicationController
  def login
    auth_hash = request.env['omniauth.auth']
    raise auth_hash.inspect
  end
end