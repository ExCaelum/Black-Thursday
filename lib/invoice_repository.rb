require_relative 'invoice'

class InvoiceRepository
  attr_accessor :invoices
  attr_reader   :sales_engine
  include Loader

  def initialize(invoice_data = [], sales_engine = nil)
    @invoices = create_invoices(invoice_data)
    @sales_engine = sales_engine
  end

  def from_csv(path)
    invoices = create_invoices(Loader.load_merchants(path))
  end

  def all
    invoices
  end

  def find_by_id(id)
    invoices.find do |invoice|
      invoice.id == id.to_i
    end
  end

  def find_all_by_customer_id(id)
    invoices.find_all do |invoice|
      invoice.customer_id == id.to_i
    end
  end

  def find_all_by_merchant_id(id)
    invoices.find_all do |invoice|
      invoice.merchant_id == id.to_i
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

  private

  def create_invoices(invoice_data)
    invoice_data.map do |invoice|
      Invoice.new(invoice, self)
    end
  end
end
