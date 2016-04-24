require_relative 'test_helper'
require './lib/transaction'

class TransactionIntegrationTest < Minitest::Test

  def test_id
    transaction = @engine.transactions.all.first
    assert_equal 941, transaction.id
  end

  def test_invoice_id
    transaction = @engine.transactions.all[1]
    assert_equal 74, transaction.invoice_id
  end

  def test_credit_card_number
    transaction = @engine.transactions.all[2]
    assert_equal 4198533248739194, transaction.credit_card_number
  end

  def test_credit_card_expiration_date
    transaction = @engine.transactions.all[3]
    assert_equal "0417", transaction.credit_card_expiration_date
  end

  def test_result
    transaction = @engine.transactions.all[4]
    assert_equal "failed", transaction.result
  end

  def test_created_at
    transaction = @engine.transactions.all[5]
    assert_equal Time, transaction.created_at.class
    assert_equal "2012-02-26 20:57:53 UTC", transaction.created_at.to_s
  end

  def test_updated_at
    transaction = @engine.transactions.all[6]
    assert_equal Time, transaction.updated_at.class
    assert_equal "2012-02-26 20:58:55 UTC", transaction.updated_at.to_s
  end
end
