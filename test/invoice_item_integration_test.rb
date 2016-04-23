require_relative 'test_helper'
require './lib/invoice_item'

class InvoiceItemIntegrationTest < Minitest::Test

  def test_id
    invoice_item = @engine.invoice_items.all.first
    assert_equal 344, invoice_item.id
  end

  def test_item_id
    invoice_item = @engine.invoice_items.all[1]
    assert_equal 263500126, invoice_item.item_id
  end

  def test_invoice_id
    invoice_item = @engine.invoice_items.all[2]
    assert_equal 139, invoice_item.invoice_id
  end

  def test_quantity
    invoice_item = @engine.invoice_items.all[3]
    assert_equal 7, invoice_item.quantity
  end

  def test_unit_price
    invoice_item = @engine.invoice_items.all[4]
    assert_equal "465.78", invoice_item.unit_price.to_digits
    assert_equal BigDecimal, invoice_item.unit_price.class
  end

  def test_unit_price_to_dollars
    invoice_item = @engine.invoice_items.all[5]
    assert_equal 841.50, invoice_item.unit_price_to_dollars
  end

  def test_created_at
    invoice_item = @engine.invoice_items.all[6]
    assert_equal Time, invoice_item.created_at.class
    assert_equal "2012-03-27 14:55:31 UTC", invoice_item.created_at.to_s
  end

  def test_updated_at
    invoice_item = @engine.invoice_items.all[7]
    assert_equal Time, invoice_item.created_at.class
    assert_equal "2012-03-27 14:55:31 UTC", invoice_item.updated_at.to_s
  end
end
