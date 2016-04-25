require_relative 'test_helper'

class CustomerRespositoryTest < Minitest::Test
  def setup
    @cr = CustomerRepository.new
  end

  def test_it_can_load_from_a_csv
    @cr.from_csv("./data/small_customers.csv")

    assert @cr.all
  end

  def test_it_can_find_all_by_first_name
    @cr.from_csv("./data/small_customers.csv")
    result = @cr.find_all_by_first_name("Wilfred")

    assert_equal Customer, result[0].class
  end

  def test_it_can_find_all_by_last_name
    @cr.from_csv("./data/small_customers.csv")
    result = @cr.find_all_by_last_name("Hettinger")

    assert_equal Customer, result[0].class
  end

  def test_inspect
    assert @cr.inspect
  end
end
