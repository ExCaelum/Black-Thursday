require_relative 'test_helper'
require './lib/transaction_repository'

class TransactionRepositoryIntegrationTest < Minitest::Test

  def test_it_has_all_transactions
    trans_array = @engine.transactions.all
    assert_equal 14, trans_array.count
  end

  def test_it_can_find_by_id
    transaction = @engine.transactions.find_by_id(3285)
    assert_equal 3285, transaction.id
  end

  def test_it_returns_nil_if_no_id
    transaction = @engine.transactions.find_by_id(177617761776)
    assert_equal nil, transaction
  end

  def test_it_can_find_all_by_invoice_id
    trans_array = @engine.transactions.find_all_by_invoice_id(74)
    transactions = trans_array.map { |trans| trans.id }
    assert_equal [941,3285], transactions
  end

  def test_it_can_find_all_by_invoice_id_empty
    trans_array = @engine.transactions.find_all_by_invoice_id(29394020)
    assert_equal [], trans_array
  end

  def test_it_can_find_all_by_credit_card_number
    trans_array = @engine.transactions.find_all_by_credit_card_number(4911072182945943)
    transactions = trans_array.map {|trans| trans.id}
    assert_equal [4388], transactions
  end

  def test_it_can_find_all_by_credit_card_number_empty
    trans_array = @engine.transactions.find_all_by_credit_card_number(929)
    assert_equal [], trans_array
  end

  def test_it_can_find_all_by_result
    trans_array = @engine.transactions.find_all_by_result("failed")
    transactions = trans_array.map {|trans| trans.id}
    assert_equal [4317,1709,2678], transactions
  end

  def test_it_can_find_all_by_result_empty
    trans_array = @engine.transactions.find_all_by_result("Lol you can't but anything")
    assert_equal [], trans_array
  end

  def test_it_can_inspect
    assert @engine.transactions.inspect
  end
end
