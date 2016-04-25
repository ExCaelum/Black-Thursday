require_relative 'test_helper'

class InvoiceRepositoryTest < Minitest::Test

  def test_it_has_all_invoices
    invoice_array = @engine.invoices.all
    invoices = invoice_array.map {|invoice| invoice.id}
    assert_equal [74,139,269,1695,548,660,949,1119,1514,1691], invoices
  end

  def test_find_by_id
    invoice = @engine.invoices.find_by_id(269)
    assert_equal 269, invoice.id
  end

  def test_find_by_id_nil
    invoice = @engine.invoices.find_by_id(47)
    assert_equal nil, invoice
  end

  def test_find_all_by_customer_id
    invoice_array = @engine.invoices.find_all_by_customer_id(128)
    invoices = invoice_array.map {|invoice| invoice.id}
    assert_equal [660], invoices
  end

  def test_find_all_by_customer_id_empty
    invoice_array = @engine.invoices.find_all_by_customer_id(47)
    assert_equal [], invoice_array
  end

  def test_find_all_by_merchant_id
    invoice_array = @engine.invoices.find_all_by_merchant_id(12334115)
    invoices = invoice_array.map {|invoice| invoice.id}
    assert_equal [949,1119], invoices
  end

  def test_find_all_by_merchant_id_empty
    invoice_array = @engine.invoices.find_all_by_merchant_id(47)
    assert_equal [], invoice_array
  end

  def test_find_all_by_status
    invoice_array = @engine.invoices.find_all_by_status(:returned)
    invoices = invoice_array.map {|invoice| invoice.id}
    assert_equal [74,269,1695,1119], invoices
  end

  def test_find_all_by_status_empty
    invoice_array = @engine.invoices.find_all_by_status('lolWtf')
    assert_equal [], invoice_array
  end

  def test_it_has_an_inspect
    assert @engine.invoices.inspect
  end
end
