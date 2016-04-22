class Invoice
  attr_accessor :invoice_data
  attr_reader   :invoice_repo

  def initialize(invoice_data, invoice_repo)
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
    invoice_data[:status]
  end

  def created_at
    invoice_data[:created_at]
  end

  def updated_at
    invoice_data[:updated_at]
  end
end
