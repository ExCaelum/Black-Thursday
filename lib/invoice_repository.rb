require_relative 'invoice'

class InvoiceRepository
  attr_accessor :invoices
  attr_reader   :sales_engine
  include Loader

  def initialize(invoice_data = [], sales_engine = nil)
    @invoices = create_invoices(invoice_data)
    @sales_engine = sales_engine
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

  def get_items(invoice_id)
    invoice_items = sales_engine.invoice_items.find_all_by_invoice_id(invoice_id)
    items = invoice_items.map do |invoice_item|
      invoice_item.item_id
    end.map do |item_id|
      sales_engine.items.find_by_id(item_id)
    end
    return nil if items[0].nil?
    items
  end

  def get_transactions(invoice_id)
    sales_engine.transactions.find_all_by_invoice_id(invoice_id)
  end

  def get_customer(customer_id)
    sales_engine.customers.find_by_id(customer_id)
  end

  def inspect
    "#<#{self.class} #{@invoices.size} rows>"
  end

  private

  def create_invoices(invoices_data)
    invoices_data.map do |invoice|
      Invoice.new(invoice, self)
    end
  end
end
