require 'csv'
require_relative 'loader'
require_relative 'merchant_repository'
require_relative 'item_repository'
require_relative 'invoice_repository'
require_relative 'invoice_item_repository'
require_relative 'transaction_repository'
require_relative 'customer_repository'

class SalesEngine
  attr_reader :merchants, :items, :invoices,
              :invoice_items, :transactions,
              :customers
  include Loader

  def initialize(merchants_data, items_data, invoice_data,
                 invoice_item_data, transaction_data,
                 customer_data)
    @merchants ||= MerchantRepository.new(merchants_data, self)
    @items ||= ItemRepository.new(items_data, self)
    @invoices ||= InvoiceRepository.new(invoice_data, self)
    @invoice_items ||= InvoiceItemRepository.new(invoice_item_data, self)
    @transactions ||= TransactionRepository.new(transaction_data, self)
    @customers ||= CustomerRepository.new(customer_data, self)
  end

  def self.from_csv(path)
    merchants_data = load_data(path[:merchants])
    items_data = load_data(path[:items])
    invoice_data = load_data(path[:invoices])
    invoice_item_data = load_data(path[:invoice_items])
    transaction_data = load_data(path[:transactions])
    customer_data = load_data(path[:customers])

    SalesEngine.new(merchants_data, items_data, invoice_data,
                    invoice_item_data, transaction_data,
                    customer_data)
  end

  def self.load_data(path)
    if path.include? "merchants"
      Loader.load_merchants(path)
    elsif path.include? "items"
      if path.include? "invoice"
        Loader.load_invoice_items(path)
      else
        Loader.load_items(path)
      end
    elsif path.include? "invoices"
      Loader.load_invoices(path)
    elsif path.include? "transaction"
      Loader.load_transactions(path)
    elsif path.include? "customer"
      Loader.load_customers(path)
    end
  end

end
