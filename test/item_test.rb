require_relative 'test_helper'

class ItemTest < Minitest::Test
  def setup
    @item = Item.new({
      :id          => 6,
      :name        => "Pencil",
      :description => "You can use it to write things",
      :merchant_id => 7,
      :unit_price  => BigDecimal.new(10.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now
      })
  end

  def test_it_has_an_id
    assert_equal 6, @item.id
  end

  def test_it_has_a_name
    assert_equal "Pencil", @item.name
  end

  def test_it_has_a_description
    assert_equal "You can use it to write things", @item.description
  end

  def test_it_has_a_unit_price
    assert_equal BigDecimal, @item.unit_price.class
  end

  def test_it_has_a_created_at
    assert_equal Time, @item.created_at.class
  end

  def test_it_has_a_updated_at
    assert_equal Time, @item.updated_at.class
  end

  def test_it_has_a_merchant_id
    assert_equal 7, @item.merchant_id
  end

  def test_it_can_convert_unit_price_to_dollars
    assert_equal 0.1099, @item.unit_price_to_dollars
  end
end
