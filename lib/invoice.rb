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
end
