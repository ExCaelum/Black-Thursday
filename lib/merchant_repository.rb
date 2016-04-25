require_relative 'merchant'

class MerchantRepository
  attr_accessor :merchants
  attr_reader   :sales_engine
  include Loader

  def initialize(merchants_data = [], sales_engine = nil)
    @merchants = create_merchants(merchants_data)
    @sales_engine = sales_engine
  end

  def from_csv(path)
    @merchants = create_merchants(Loader.load_merchants(path))
  end

  def all
    merchants
  end

  def find_by_id(id)
    merchants.find do |merchant|
      merchant.id == id
    end
  end

  def find_by_name(name)
    merchants.find do |merchant|
      merchant.name.downcase == name.downcase
    end
  end

  def find_all_by_name(name)
    merchants.find_all do |merchant|
      merchant.name.downcase.include?(name.downcase)
    end
  end

  def get_items(id)
    sales_engine.items.find_all_by_merchant_id(id)
  end

  def get_invoices(id)
    sales_engine.invoices.find_all_by_merchant_id(id)
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end

  private

  def create_merchants(merchants_data)
    merchants_data.map do |merchant_data|
      Merchant.new(merchant_data, self)
    end
  end
end
