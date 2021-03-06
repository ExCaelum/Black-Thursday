require 'bigdecimal'
require 'time'
require 'date'

class Item
  attr_accessor :item_data
  attr_reader   :item_repo

  def initialize(item_data, item_repo = nil)
    @item_data = item_data
    @item_repo = item_repo
  end

  def id
    item_data[:id].to_i
  end

  def name
    item_data[:name]
  end

  def description
    item_data[:description]
  end

  def unit_price
    BigDecimal.new(item_data[:unit_price], 4) / BigDecimal.new(100)
  end

  def unit_price_to_dollars
    unit_price.to_f
  end

  def created_at
    if item_data[:created_at].class == String
      Time.parse(item_data[:created_at])
    elsif item_data[:created_at].class == Time
      item_data[:created_at]
    end
  end

  def updated_at
    if item_data[:updated_at].class == String
      Time.parse(item_data[:updated_at])
    elsif item_data[:updated_at].class == Time
      item_data[:updated_at]
    end
  end

  def merchant_id
    item_data[:merchant_id].to_i
  end

  def merchant
    item_repo.get_merchant(merchant_id)
  end
end
