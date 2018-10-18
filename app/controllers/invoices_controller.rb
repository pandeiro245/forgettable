class InvoicesController < ApplicationController
  def index
   @invoices = MisocaApi::invoices(session[:misoca_token])
  end

  def show
    @invoice = MisocaApi::invoice(session[:misoca_token], params[:id])
    @invoice_pdf = MisocaApi::invoice_pdf(session[:misoca_token], params[:id])
  end
end
