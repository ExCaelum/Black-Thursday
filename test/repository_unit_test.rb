require_relative 'test_helper'

class RepositoryLoadTest < Minitest::Test
  def setup
    @merchant_repo = MerchantRepository.new
    @item_repo = ItemRepository.new
    @invoice_repo = InvoiceRepository.new
  end

  def test_merchant_can_load_from_csv
    @merchant_repo.from_csv("./data/small_merchants.csv")
    merchants = @merchant_repo.all
    assert_equal Merchant, merchants.first.class
  end

  def test_item_can_load_from_csv
    @item_repo.from_csv("./data/small_items.csv")
    items = @item_repo.all
    assert_equal Item, items.first.class
  end

  def test_invoice_can_load_from_csv
    @invoice_repo.from_csv("./data/small_invoices.csv")
    invoices = @invoice_repo.all
    assert_equal Invoice, invoices.first.class
  end
end
