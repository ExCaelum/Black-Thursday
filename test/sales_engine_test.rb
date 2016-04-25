require_relative 'test_helper.rb'

class SalesEngineTest < Minitest::Test

  def test_it_creates_repos
    assert_equal MerchantRepository, @engine.merchants.class
    assert_equal ItemRepository, @engine.items.class
    assert_equal InvoiceRepository, @engine.invoices.class
    assert_equal InvoiceItemRepository, @engine.invoice_items.class
    assert_equal TransactionRepository, @engine.transactions.class
  end

end
