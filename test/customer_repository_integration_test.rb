require_relative 'test_helper'

class CustomerIntegrationTest < Minitest::Test

  def test_it_has_all_customers
    customer_array = @engine.customers.all
    customers = customer_array.map {|customer| customer.id}
    assert_equal [14,28,51,106,128,182,220,300,338,339], customers
  end

  def test_find_by_id
    customer = @engine.customers.find_by_id(14)
    assert_equal 14, customer.id
  end

  def test_find_by_id_nil
    customer = @engine.customers.find_by_id(800002)
    assert_equal nil, customer
  end

  def test_find_all_by_first_name
    customer_array = @engine.customers.find_all_by_first_name("ErNeSTo")
    customers = customer_array.map {|customer| customer.first_name}
    assert_equal ["Ernesto"], customers
  end

  def test_all_by_first_name_empty
    customer_array = @engine.customers.find_all_by_first_name("RYyAn")
    assert_equal [], customer_array
  end

  def test_find_all_by_last_name
    customer_array = @engine.customers.find_all_by_last_name("rYAn")
    customer = customer_array.map {|customer| customer.first_name}
    assert_equal ["Roma"], customer
  end

  def test_find_all_by_last_name_empty
    customer_array = @engine.customers.find_all_by_last_name("WinhaM")
    assert_equal [], customer_array
  end

  def test_it_has_an_inspect
    assert @engine.customers.inspect
  end
end
