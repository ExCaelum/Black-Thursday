class Invoice
  attr_accessor :invoice_data

  def initialize(invoice)
    @invoice_data = invoice
  end

  def id
    invoice_data[:id]
  end

  def customer_id
    invoice_data[:customer_id]
  end

  def merchant_id
    invoice_data[:merchant_id]
  end

  def status
    invoice_data[:status]
  end

  def created_at
    invoice_data[:created_at]
  end

  def updated_at
    invoice_data[:updated_at]
  end
end
