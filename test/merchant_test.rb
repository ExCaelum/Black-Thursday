require_relative 'test_helper'

class MerchantTest < Minitest::Test
  def setup
    @merchant = Merchant.new({
      :id          => 6,
      :name        => "Turing School",
      :created_at  => Time.now,
      :updated_at  => Time.now
      })
  end

  def test_it_has_an_id
    assert_equal 6, @merchant.id
  end

  def test_it_has_a_name
    assert_equal "Turing School", @merchant.name
  end

  def test_it_has_a_created_at
    assert_equal Time, @merchant.created_at.class
  end

  def test_it_has_a_updated_at
    assert_equal Time, @merchant.updated_at.class
  end
end
