require_relative 'test_helper'

class TransactionRepositoryTest < Minitest::Test
  def setup
    @tr = TransactionRepository.new
  end

  def test_it_can_load_from_a_csv
    @tr.from_csv("./data/transactions.csv")

    assert @tr.all
  end
end
