require 'csv'
require_relative 'merchant_repository'
require_relative 'item_repository'

class SalesEngine
  attr_reader :merchants, :items

  def initialize(merchants_data, items_data)
    @merchants = MerchantRepository.new(merchants_data, self)
    @items = ItemRepository.new(items_data, self)
  end

  def self.from_csv(path)
    merchants_data = load_data(path[:merchants])
    items_data = load_data(path[:items])

    SalesEngine.new(merchants_data, items_data)
  end

  def self.load_data(path)
    contents = CSV.open(path, headers: true, header_converters: :symbol)
    if path == './data/small_merchants.csv' || path == './data/merchants.csv'
      load_merchants(contents)
    elsif path == './data/small_items.csv' || path == './data/items.csv'
      load_items(contents)
    elsif path == './data/small_invoices.csv' || path == './data/invoices.csv'
      load_invoices(contents)
    end
  end

  def self.load_merchants(contents)
    all_merchants = contents.map do |row|
      data_hash = {}
      data_hash[:id] = row[:id]
      data_hash[:name] = row[:name]
      data_hash[:created_at] = row[:created_at]
      data_hash[:updated_at] = row[:updated_at]
      data_hash
    end
    all_merchants
  end

  def self.load_items(contents)

    all_items = contents.map do |row|
      data_hash = {}
      data_hash[:id] = row[:id]
      data_hash[:name] = row[:name]
      data_hash[:description] = row[:description]
      data_hash[:unit_price] = row[:unit_price]
      data_hash[:merchant_id] = row[:merchant_id]
      data_hash[:created_at] = row[:created_at]
      data_hash[:updated_at] = row[:updated_at]
      data_hash
    end
    all_items
  end

  def self.load_invoice(contents)

    all_invoices = contents.map do |row|
      data_hash = {}
      data_hash[:id] = row[:id]
      data_hash[:customer_id] = row[:customer_id]
      data_hash[:merchant_id] = row[:merchant_id]
      data_hash[:status] = row[:status]
      data_hash[:created_at] = row[:created_at]
      data_hash[:updated_at] = row[:updated_at]
      data_hash
    end
    all_invoices
  end

end
