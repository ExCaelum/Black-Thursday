require_relative 'test_helper'

class TransactionTest < Minitest::Test
  def setup
    @trans = Transaction.new({
      :id => 6,
      :invoice_id => 8,
      :credit_card_number => "4242424242424242",
      :credit_card_expiration_date => "0220",
      :result => "success",
      :created_at => Time.now,
      :updated_at => Time.now
    })
  end

  def test_id
    assert_equal 6, @trans.id
  end

  def test_invoice_id
    assert_equal 8, @trans.invoice_id
  end

  def test_credit_card_number
    assert_equal 4242424242424242, @trans.credit_card_number
  end

  def test_credit_card_expiration_date
    assert_equal "0220", @trans.credit_card_expiration_date
  end

  def test_result
    assert_equal "success", @trans.result
  end

  def test_created_at
    assert_equal Time, @trans.created_at.class
  end

  def test_updated_at
    assert_equal Time, @trans.updated_at.class
  end
end
