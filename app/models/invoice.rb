class Invoice
  class << self
    def all(token)
      MisocaApi::invoices(token)
    end

    def find(token, id)
      MisocaApi::invoice(token, id)
    end

    def find_pdf(token, id)
      MisocaApi::invoice_pdf(token, id)
    end
  end
end
