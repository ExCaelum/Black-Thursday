require_relative 'test_helper'

class InvoiceItemTest < Minitest::Test
  def setup
    @invoice_item = InvoiceItem.new({
      :id => 6,
      :item_id => 7,
      :invoice_id => 8,
      :quantity => 1,
      :unit_price => BigDecimal.new(1099, 4),
      :created_at => Time.now,
      :updated_at => Time.now
    }, nil)
  end

  def test_it_has_an_id
    assert_equal 6, @invoice_item.id
  end

  def test_it_has_item_id
    assert_equal 7, @invoice_item.item_id
  end

  def test_invoice_id
    assert_equal 8, @invoice_item.invoice_id
  end

  def test_it_has_quantity
    assert_equal 1, @invoice_item.quantity
  end

  def test_it_has_unit_price
    assert_equal "10.99", @invoice_item.unit_price.to_digits
    assert_equal BigDecimal, @invoice_item.unit_price.class
  end

  def test_it_can_convert_unit_price_to_dollars
    assert_equal 10.99, @invoice_item.unit_price_to_dollars
  end

  def test_it_has_a_created_at
    assert_equal Time, @invoice_item.created_at.class
  end

  def test_it_has_a_updated_at
    assert_equal Time, @invoice_item.updated_at.class
  end
end
