class InvoiceItem
  attr_accessor :invoice_item_data
  attr_reader   :invoice_item_repo

  def initialize(invoice_item_data, invoice_item_repo = nil)
    @invoice_item_data = invoice_item_data
    @invoice_item_repo = invoice_item_repo
  end

  def id
    invoice_item_data[:id].to_i
  end

  def item_id
    invoice_item_data[:item_id].to_i
  end

  def invoice_id
    invoice_item_data[:invoice_id].to_i
  end

  def quantity
    invoice_item_data[:quantity].to_i
  end

  def unit_price
    BigDecimal.new(invoice_item_data[:unit_price], 4) / BigDecimal.new(100)
  end

  def unit_price_to_dollars
    unit_price.to_f
  end

  def created_at
    if invoice_item_data[:created_at].class == String
      Time.parse(invoice_item_data[:created_at])
    elsif invoice_item_data[:created_at].class == Time
      invoice_item_data[:created_at]
    end
  end

  def updated_at
    if invoice_item_data[:updated_at].class == String
      Time.parse(invoice_item_data[:updated_at])
    elsif invoice_item_data[:updated_at].class == Time
      invoice_item_data[:updated_at]
    end
  end
end
