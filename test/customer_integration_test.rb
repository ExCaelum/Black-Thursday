require_relative 'test_helper'

class CustomerIntegrationTest < Minitest::Test

  def test_id
    customer = @engine.customers.all.first
    assert_equal 14, customer.id
  end

  def test_first_name
    customer = @engine.customers.all[1]
    assert_equal "Wilfred", customer.first_name
  end

  def test_last_name
    customer = @engine.customers.all[2]
    assert_equal "Stark", customer.last_name
  end

  def test_it_has_a_created_at
    customer = @engine.customers.all[3]
    assert_equal Time, customer.created_at.class
    assert_equal "2012-03-27 14:54:34 UTC", customer.created_at.to_s
  end

  def test_it_has_an_updated_at
    customer = @engine.customers.all[4]
    assert_equal Time, customer.updated_at.class
    assert_equal "2012-03-27 14:54:40 UTC", customer.updated_at.to_s
  end
end
