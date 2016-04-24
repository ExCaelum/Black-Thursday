require_relative 'test_helper'

class CustomerTest < Minitest::Test
  def setup
    @customer = Customer.new({
      :id          => 6,
      :first_name  => "Joan",
      :last_name   => "Clarke",
      :created_at  => Time.now,
      :updated_at  => Time.now,
      }, nil)
  end

  def test_it_has_an_id
    assert_equal 6, @customer.id
  end

  def test_it_has_a_first_name
    assert_equal "Joan", @customer.first_name
  end

  def test_it_has_a_last_name
    assert_equal "Clarke", @customer.last_name
  end

  def test_it_has_a_created_at
    assert_equal Time, @customer.created_at.class
  end

  def test_it_has_a_updated_at
    assert_equal Time, @customer.updated_at.class
  end
end
