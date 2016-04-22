require_relative 'invoice'

class InvoiceRepository
  attr_accessor :invoices
  attr_reader   :sales_engine

  def initialize(invoice_data, sales_engine)
    @invoices = invoice_data.map do |invoice|
      Invoice.new(invoice, self)
    end
    @sales_engine = sales_engine
  end

  def all
    invoices
  end

  def find_by_id(id)
    invoices.find do |invoice|
      invoice.id == id
    end
  end

  def find_all_by_customer_id(id)
    invoices.find_all do |invoice|
      invoice.customer_id == id
    end
  end

  def find_all_by_merchant_id(id)
    invoices.find_all do |invoice|
      invoice.merchant_id == id
    end
  end

  def find_all_by_status(status)
    invoices.find_all do |invoice|
      invoice.status.downcase == status.downcase
    end
  end

  def get_merchant(merchant_id)
    sales_engine.merchants.find_by_id(merchant_id)
  end

  def inspect
    "#<#{self.class} #{@invoices.size} rows>"
  end

end
