require_relative 'test_helper'

class SalesAnalystTest < Minitest::Test

  def test_it_exists
    assert_equal SalesAnalyst, @analyst.class
  end

  def test_it_has_sales_engine
    assert_equal SalesEngine, @analyst.engine.class
  end

  def test_average_items_per_merchant
    assert_equal 1.8, @analyst.average_items_per_merchant
  end

  def test_average_items_per_merchant_standard_deviation
    assert_equal 0.89, @analyst.average_items_per_merchant_standard_deviation
  end

  def test_merchants_with_high_item_count
    high_item_merchants = @analyst.merchants_with_high_item_count
    high_item_merchants = high_item_merchants.map {|merchant| merchant.name}
    assert_equal ["Shopin1901"], high_item_merchants
  end

  def test_average_item_price_for_merchant
    assert_equal "16.66", @analyst.average_item_price_for_merchant(12334105).to_digits
    assert_equal BigDecimal, @analyst.average_item_price_for_merchant(12334105).class
  end

  def test_average_price_for_all_merchants
    assert_equal '43.13', @analyst.average_average_price_per_merchant.to_digits
    assert_equal BigDecimal, @analyst.average_average_price_per_merchant.class
  end

  def test_average_price_of_items
    assert_equal '30.22', @analyst.average_price_of_items.to_digits
    assert_equal BigDecimal, @analyst.average_price_of_items.class
  end

  def test_average_price_of_items_standard_deviation
    assert_equal 45.4, @analyst.average_price_of_items_standard_deviation
  end

  def test_golden_items
    golden_array = @analyst.golden_items.map {|item| item.name}
    assert_equal ['Custom Hand Made Miniature Bicycle'], golden_array
  end

  def test_it_can_calculate_the_percentage_of_invoices_shipped
    result = @analyst.invoice_status(:shipped)

    assert_equal 44.44, result
  end

  def test_it_can_calculate_the_percentage_of_invoices_pending
    result = @analyst.invoice_status(:pending)

    assert_equal 11.11, result
  end

  def test_it_can_calculate_the_percentage_of_invoices_returned
    result = @analyst.invoice_status(:returned)

    assert_equal 44.44, result
  end

  def test_it_can_calculate_the_days_invoices_are_created_more
    result = @analyst.top_days_by_invoice_count

    assert_equal ["Monday"], result
  end

  def test_it_can_calculate_average_invoices_per_merchant
    result = @analyst.average_invoices_per_merchant

    assert_equal 1.8, result
  end

  def test_it_can_calculate_invoices_per_merchant_standard_deviation
    result = @analyst.average_invoices_per_merchant_standard_deviation

    assert_equal 0.45, result
  end

  def test_it_can_calculate_the_top_performing_merchants
    result = @analyst.top_merchants_by_invoice_count

    assert_equal [], result
  end

  def test_it_can_calculate_the_lowest_performing_merchants
    result = @analyst.bottom_merchants_by_invoice_count

    assert_equal [], result
  end

  def test_we_can_find_merchants_with_pending_invoices
    merchant_array = @analyst.merchants_with_pending_invoices
    result = merchant_array.map {|merchant| merchant.id}

    assert_equal [12334105], result
    assert_equal [Merchant], merchant_array.map {|merchant| merchant.class}
  end

  def test_merchants_with_only_one_item
    merchant_array = @analyst.merchants_with_only_one_item
    merchants = merchant_array.map {|merchant| merchant.name}
    assert_equal ["Candisart", "MiniatureBikez", "LolaMarleys", "GoldenRayPress"], merchants
  end

  def test_revenue_by_merchant
    result = @analyst.revenue_by_merchant(12334113)
    assert_equal "7366.49", result.to_digits
    assert_equal BigDecimal, result.class
  end

  def test_top_3_revenue_earners
    result = @analyst.top_revenue_earners(3)
    assert_equal ["GoldenRayPress", "Candisart", "Shopin1901"], result
  end
end
