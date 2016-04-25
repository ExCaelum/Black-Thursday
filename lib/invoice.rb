class Invoice
  attr_accessor :invoice_data
  attr_reader   :invoice_repo

  def initialize(invoice_data, invoice_repo = nil)
    @invoice_data = invoice_data
    @invoice_repo = invoice_repo
  end

  def id
    invoice_data[:id].to_i
  end

  def customer_id
    invoice_data[:customer_id].to_i
  end

  def merchant_id
    invoice_data[:merchant_id].to_i
  end

  def status
    invoice_data[:status].intern
  end

  def created_at
    if invoice_data[:created_at].class == String
      Time.parse(invoice_data[:created_at])
    elsif invoice_data[:created_at].class == Time
      invoice_data[:created_at]
    end
  end

  def updated_at
    if invoice_data[:updated_at].class == String
      Time.parse(invoice_data[:updated_at])
    elsif invoice_data[:updated_at].class == Time
      invoice_data[:updated_at]
    end
  end

  def merchant
    invoice_repo.get_merchant(merchant_id)
  end

  def items
    invoice_repo.get_items(id)
  end

  def transactions
    invoice_repo.get_transactions(id)
  end

  def customer
    invoice_repo.get_customer(customer_id)
  end

  def is_paid_in_full?
    transactions.any? do |transaction|
      transaction.result == "success"
    end
  end

  def total
    if is_paid_in_full?
      invoice_items = invoice_repo.sales_engine.invoice_items
      invoice_items.find_all_by_invoice_id(id).map do |invoice_item|
        invoice_item.quantity * invoice_item.unit_price
      end.reduce(:+)
    end
  end
end
