require_relative 'item'

class ItemRepository
  attr_accessor :items
  attr_reader   :sales_engine
  include Loader

  def initialize(items_data = [], sales_engine = nil)
    @items = create_items(items_data)
    @sales_engine = sales_engine
  end

  def from_csv(path)
    @items = create_items(Loader.load_items(path))
  end

  def all
    items
  end

  def find_by_id(id)
    items.find do |item|
      item.id == id.to_i
    end
  end

  def find_by_name(name)
    items.find do |item|
      item.name.downcase == name.downcase
    end
  end

  def find_all_with_description(description)
    items.find_all do |item|
      item.description.downcase.include? description.downcase
    end
  end

  def find_all_by_price(price)
    items.find_all do |item|
      item.unit_price_to_dollars == price.to_f
    end
  end

  def find_all_by_price_in_range(price)
    items.find_all do |item|
      price.include?(item.unit_price_to_dollars)
    end
  end

  def find_all_by_merchant_id(merch_id)
    items.find_all do |item|
      item.merchant_id == merch_id.to_i
    end
  end

  def get_merchant(merchant_id)
    sales_engine.merchants.find_by_id(merchant_id)
  end

  def inspect
    "#<#{self.class} #{@items.size} rows>"
  end

  private

  def create_items(items_data)
    items_data.map do |item_data|
      Item.new(item_data, self)
    end
  end
end
