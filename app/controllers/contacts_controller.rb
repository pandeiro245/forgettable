class ContactsController < ApplicationController
  def index
    @contacts = MisocaApi::contacts(session[:misoca_token])
  end

  def show
    @contact = MisocaApi::contact(session[:misoca_token], params[:id])
  end
end
