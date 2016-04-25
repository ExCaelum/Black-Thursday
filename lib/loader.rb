module Loader

  def self.contents(path)
    CSV.open(path, headers: true, header_converters: :symbol)
  end

  def self.load_merchants(path)
    all_merchants = contents(path).map do |row|
      data_hash = {}
      data_hash[:id] = row[:id]
      data_hash[:name] = row[:name]
      data_hash[:created_at] = row[:created_at]
      data_hash[:updated_at] = row[:updated_at]
      data_hash
    end
    all_merchants
  end

  def self.load_items(path)
    all_items = contents(path).map do |row|
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

  def self.load_invoices(path)
    all_invoices = contents(path).map do |row|
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

  def self.load_invoice_items(path)
    all_invoice_items = contents(path).map do |row|
      data_hash = {}
      data_hash[:id] = row[:id]
      data_hash[:item_id] = row[:item_id]
      data_hash[:invoice_id] = row[:invoice_id]
      data_hash[:quantity] = row[:quantity]
      data_hash[:unit_price] = row[:unit_price]
      data_hash[:created_at] = row[:created_at]
      data_hash[:updated_at] = row[:updated_at]
      data_hash
    end
    all_invoice_items
  end

  def self.load_transactions(path)
    all_transactions = contents(path).map do |row|
      data_hash = {}
      data_hash[:id] = row[:id]
      data_hash[:invoice_id] = row[:invoice_id]
      data_hash[:credit_card_number] = row[:credit_card_number]
      data_hash[:credit_card_expiration_date] = row[:credit_card_expiration_date]
      data_hash[:result] = row[:result]
      data_hash[:created_at] = row[:created_at]
      data_hash[:updated_at] = row[:updated_at]
      data_hash
    end
    all_transactions
  end

  def self.load_customers(path)
    all_customers = contents(path).map do |row|
      data_hash = {}
      data_hash[:id] = row[:id]
      data_hash[:first_name] = row[:first_name]
      data_hash[:last_name] = row[:last_name]
      data_hash[:created_at] = row[:created_at]
      data_hash[:updated_at] = row[:updated_at]
      data_hash
    end
    all_customers
  end
end
