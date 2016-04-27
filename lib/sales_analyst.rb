require 'bigdecimal/util'
require_relative 'sales_engine'

class SalesAnalyst
  attr_reader :engine

  def initialize(sales_engine)
    @engine = sales_engine
  end

  def average_items_per_merchant
    (items.count.to_f / merchants.count.to_f).round(2)
  end

  def average_price_of_items
    prices = items.map {|item| item.unit_price}
    total_price = prices.reduce(:+)
    average_price = total_price / items.count
    average_price.round(2)
  end

  def average_invoices_per_merchant
    merchant_totals = merchants.map { |merchant| merchant.invoices.count.to_f }
    (merchant_totals.reduce(:+)/merchant_totals.length.to_f).round(2)
  end

  def average_items_per_merchant_standard_deviation
    merchant_items = find_merchant_ids.map do |id|
      items_by_merchant_id(id).size.to_f
    end
    standard_deviation(merchant_items)
  end

  def average_price_of_items_standard_deviation
    item_prices = items.map {|item| item.unit_price}
    standard_deviation(item_prices)
  end

  def merchants_with_high_item_count
    standard = (average_items_per_merchant +
                average_items_per_merchant_standard_deviation)
    merchants.find_all do |merchant|
      merchant.items.count > standard
    end
  end

  def golden_items
    golden_price = average_price_of_items_standard_deviation*2 +
                   average_price_of_items
    golden = items.find_all do |item|
      item.unit_price >= golden_price
    end
    golden
  end


  def average_item_price_for_merchant(id)
    merchant = merchant_repo.find_by_id(id)
    prices = merchant.items.map {|item| item.unit_price}
    average_price = (prices.reduce(:+) / prices.count).round(2)
    average_price
  end

  def average_average_price_per_merchant
    merchant_ids = find_merchant_ids
    average_prices = merchant_ids.map do |merch_id|
      average_item_price_for_merchant(merch_id)
    end.reduce(:+)
    (average_prices / merchants.size).round(2)
  end

  def invoice_status(status_symbol)
    total_invoices = invoices.count.to_f
    requested_type = invoices.find_all do |invoice|
      invoice.status == status_symbol
    end
    requested_type_count = requested_type.count
    ((requested_type_count / total_invoices) * 100).round(2)
  end

  def invoice_totals_by_day
    totals = [0,0,0,0,0,0,0]
    invoices.each do |invoice|
      totals[invoice.created_at.wday] += 1
    end
    totals
  end

  def top_days_by_invoice_count
    threshold = (invoice_totals_by_day.reduce(:+) /
                 invoice_totals_by_day.length) +
                 standard_deviation(invoice_totals_by_day)

    result = []
    result << "Sunday" if invoice_totals_by_day[0] > threshold
    result << "Monday" if invoice_totals_by_day[1] > threshold
    result << "Tuesday" if invoice_totals_by_day[2] > threshold
    result << "Wednesday" if invoice_totals_by_day[3] > threshold
    result << "Thursday" if invoice_totals_by_day[4] > threshold
    result << "Friday" if invoice_totals_by_day[5] > threshold
    result << "Saturday" if invoice_totals_by_day[6] > threshold

    result
  end

  def average_invoices_per_merchant_standard_deviation
    merchant_totals = merchants.map { |merchant| merchant.invoices.count.to_f }
    standard_deviation(merchant_totals).round(2)
  end

  def top_merchants_by_invoice_count
    threshold = average_invoices_per_merchant +
                  (average_invoices_per_merchant_standard_deviation*2)
    merchants.find_all { |merchant| merchant.invoices.count > threshold}
  end

  def bottom_merchants_by_invoice_count
    threshold = average_invoices_per_merchant -
                  (average_invoices_per_merchant_standard_deviation*2)
    merchants.find_all { |merchant| merchant.invoices.count < threshold}
  end

  def merchants_with_pending_invoices
    pending_invoices = invoice_repo.find_all_by_status(:pending)
    pending_merchants = pending_invoices.map do |invoice|
      invoice.merchant
    end.uniq
    pending_merchants
  end

  def merchants_with_only_one_item
    merchants.find_all {|merchant| merchant.items.count == 1}
  end

  def revenue_by_merchant(merchant_id)
    invoices = find_merchant_invoices(merchant_id)
    valid_invoices = invoices.select{|invoice| invoice.is_paid_in_full? }
    valid_invoices.reduce(0) {|sum, invoice| sum + invoice.total}
  end

  def top_revenue_earners(merchant_amount = 20)
    merchant_ids = merchants.map {|merchant| merchant.id}
    sorted = merchant_ids.sort_by do |merchant_id|
      revenue_by_merchant(merchant_id)
    end.reverse
    merchants = sorted.map {|id| merchant_repo.find_by_id(id)}
    merchants.take(merchant_amount)
  end

  def merchants_ranked_by_revenue
    top_revenue_earners(merchants.length)
  end

  def most_sold_item_for_merchant(merchant_id)
    initial_invoice_items = find_merchant_invoice_items(merchant_id)
    invoice_items = initial_invoice_items.find_all do |invoice_item|
      invoice_repo.find_by_id(invoice_item.invoice_id).is_paid_in_full?
    end
    hash = {}
    keys = invoice_items.map {|invoice_item| invoice_item.quantity}.uniq
    keys.each {|key| hash[key] = []}

    invoice_items.each do |invoice_item|
      hash[invoice_item.quantity] << item_repo.find_by_id(invoice_item.item_id)
    end

    hash[hash.keys.max]
  end

  def best_item_for_merchant(merchant_id)
    invoice_items = find_merchant_invoice_items(merchant_id)
    valid_invoice_items = invoice_items.find_all do |invoice_item|
      invoice_repo.find_by_id(invoice_item.invoice_id).is_paid_in_full?
    end

    sorted = valid_invoice_items.sort_by do |invoice_item|
      (invoice_item.unit_price * invoice_item.quantity)
    end

    item_repo.find_by_id(sorted.last.item_id)
  end

  def total_revenue_by_date(date)
    invoices.reduce(0) do |sum, invoice|
      if invoice.created_at.strftime("%F") == date.strftime("%F")
        sum + invoice.total
      else
        sum
      end
    end

  end

  private

  def item_repo
    engine.items
  end

  def merchant_repo
    engine.merchants
  end

  def invoice_repo
    engine.invoices
  end

  def items
    item_repo.all
  end

  def merchants
    merchant_repo.all
  end

  def invoices
    invoice_repo.all
  end

  def invoice_items
    engine.invoice_items.all
  end

  def items_by_merchant_id(id)
    item_repo.find_all_by_merchant_id(id)
  end

  def find_merchant_ids
    merchants.map {|merch| merch.id}
  end

  def find_merchant_invoices(merchant_id)
    merchant_repo.find_by_id(merchant_id).invoices
  end

  def find_merchant_invoice_items(merchant_id)
    invoices = find_merchant_invoices(merchant_id)
    invoice_ids = invoices.map {|invoice| invoice.id}
    invoice_items = invoice_ids.map do |id|
      engine.invoice_items.find_all_by_invoice_id(id)
    end.flatten
  end
  def standard_deviation(array)
    mean = array.reduce(:+) / array.count
    second_array = array.map {|number| (number - mean) ** 2}
    product = second_array.reduce(:+) / (array.count - 1)
    deviation = Math.sqrt(product).round(2)
    deviation
  end

end
