require_relative 'test_helper'

class InvoiceItemRepositoryTest < Minitest::Test
  def setup
    @ir = InvoiceItemRepository.new
  end

  def test_it_can_load_from_a_csv
    @ir.from_csv("./data/invoice_items.csv")

    assert @ir.all
  end
end
