
class Merchant
  attr_accessor :merchant_data
  attr_reader   :merchant_repo

  def initialize(merchant_data, merchant_repo = nil)
    @merchant_data = merchant_data
    @merchant_repo = merchant_repo
  end

  def id
    merchant_data[:id].to_i
  end

  def name
    merchant_data[:name]
  end

  def created_at
    merchant_data[:created_at]
  end

  def updated_at
    merchant_data[:updated_at]
  end

  def items
    merchant_repo.get_items(id)
  end

  def invoices
    merchant_repo.get_invoices(id)
  end

  def customers
    invoices.map do |invoice|
      invoice.customer
    end.uniq
  end

end
