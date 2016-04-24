require_relative 'test_helper'

class InvoiceItemRepositoryTest < Minitest::Test

  def test_all
    invoice_item_array = @engine.invoice_items.all
    assert_equal 19, invoice_item_array.count
  end

  def test_find_by_id
    invoice_item = @engine.invoice_items.find_by_id(344)
    assert_equal 344, invoice_item.id
  end

  def test_find_by_id_nil
    invoice_item = @engine.invoice_items.find_by_id(1010101)
    assert_equal nil, invoice_item
  end

  def test_find_all_by_item_id
    invoice_item_array = @engine.invoice_items.find_all_by_item_id(263453811)
    invoice_items = invoice_item_array.map {|invoice_item| invoice_item.id}
    assert_equal [4227], invoice_items
  end

  def test_all_by_item_id_empty
    invoice_item_array = @engine.invoice_items.find_all_by_item_id(02020202020)
    assert_equal [], invoice_item_array
  end

  def test_find_all_by_invoice_id
    invoice_item_array = @engine.invoice_items.find_all_by_invoice_id(139)
    invoice_items = invoice_item_array.map {|invoice_item| invoice_item.id}
    assert_equal [649,650], invoice_items
  end

  def test_find_all_by_invoice_id_empty
    invoice_item_array = @engine.invoice_items.find_all_by_invoice_id(1111111)
    assert_equal [], invoice_item_array
  end

  def test_inspect
    assert @engine.invoice_items.inspect
  end

end
