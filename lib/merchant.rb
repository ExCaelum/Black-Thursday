
class Merchant
  attr_accessor :merchant_data
  attr_reader   :merchant_repo

  def initialize(merchant_data, merchant_repo)
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
    engine = merchant_repo.sales_engine
    engine.items.find_all_by_merchant_id(id)
  end

end
