class InvoicesController < ApplicationController
  def index
   @invoices = Invoice.all(session[:misoca_token])
  end

  def show
    @invoice = Invoice.find(session[:misoca_token], params[:id])
    @invoice_pdf = Invoice.find_pdf(session[:misoca_token], params[:id])
  end
end
