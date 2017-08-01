require './lib/pantry'
require './lib/recipe'
require 'minitest/autorun'
require 'minitest/pride'

class PantryTest < Minitest::Test
  def setup
    @pantry = Pantry.new
  end

  def test_it_exists
    assert_instance_of Pantry, @pantry
  end

  def test_stock_starts_empty
    empty_hash = {}
    assert_equal empty_hash, @pantry.stock
  end

  def test_stock_check_returns_0_if_no_item
    assert_equal 0, @pantry.stock_check("Cheese")
  end

  def test_restock_food_item
    @pantry.restock("Cheese", 10)
    assert_equal 10, @pantry.stock_check("Cheese")
  end

  def test_it_can_convert_units
    r = Recipe.new("Spicy Cheese Pizza")
    r.add_ingredient("Cayenne Pepper", 0.025)
    r.add_ingredient("Cheese", 75)
    r.add_ingredient("Flour", 500)
    cayenne_hash = {quantity: 25, units: "Milli-Units"}
    cheese_hash = {quantity: 75, units: "Universal Units"}
    flour_hash = {quantity: 5, units: "Centi-Units"}

    assert_equal @pantry.convert_units(r)["Cayenne Pepper"], cayenne_hash
    assert_equal @pantry.convert_units(r)["Cheese"], cheese_hash
    assert_equal @pantry.convert_units(r)["Flour"], flour_hash
  end

end
