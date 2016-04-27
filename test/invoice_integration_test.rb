require_relative 'test_helper'

class InvoiceIntegrationTest < Minitest::Test

  def test_id
    invoice = @engine.invoices.all.first
    assert_equal 74, invoice.id
  end

  def test_it_has_a_customer_id
    invoice = @engine.invoices.all[1]
    assert_equal 28, invoice.customer_id
  end

  def test_it_has_a_merchant_id
    invoice = @engine.invoices.all[2]
    assert_equal 12334112, invoice.merchant_id
  end

  def test_it_has_a_status
    invoice = @engine.invoices.all[3]
    assert_equal :returned, invoice.status
  end

  def test_it_has_a_created_at
    invoice = @engine.invoices.all[4]
    assert_equal Time, invoice.created_at.class
    assert_equal "2005-07-18 00:00:00 -0600", invoice.created_at.to_s
  end

  def test_it_has_a_updated_at
    invoice = @engine.invoices.all[5]
    assert_equal Time, invoice.updated_at.class
    assert_equal "2013-05-28 00:00:00 -0600", invoice.updated_at.to_s
  end

  def test_invoice_can_find_its_merchant
    invoice = @engine.invoices.all.first
    assert_equal 74, invoice.id
    merchant = invoice.merchant
    assert_equal 'Shopin1901', merchant.name
  end

  def test_it_can_find_its_items_that_dont_exist
    invoice = @engine.invoices.all[7]

    assert_equal nil, invoice.items
  end

  def test_it_can_find_items
    invoice = @engine.invoices.all[6]
    items = invoice.items.map {|item| item.id}
    assert_equal [263413709, 263562568], items
  end

  def test_it_can_find_its_transactions
    invoice = @engine.invoices.all[6]

    assert_equal Transaction, invoice.transactions[0].class
  end

  def test_it_can_find_its_customer
    invoice = @engine.invoices.all[7]

    assert_equal Customer, invoice.customer.class
  end

  def test_it_can_get_the_total_paid
    invoice = @engine.invoices.all[8]

    assert_equal 9022.25, invoice.total.to_f
  end
end
