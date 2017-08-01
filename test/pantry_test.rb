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

  def test_it_can_add_recipes_to_cookbook
    r1 = Recipe.new("Cheese Pizza")
    r1.add_ingredient("Cheese", 20)
    r1.add_ingredient("Flour", 20)
    r2 = Recipe.new("Brine Shot")
    r2.add_ingredient("Brine", 10)
    r3 = Recipe.new("Peanuts")
    r3.add_ingredient("Raw nuts", 10)
    r3.add_ingredient("Salt", 10)
    # Adding the recipe to the cookbook
    @pantry.add_to_cookbook(r1)
    @pantry.add_to_cookbook(r2)
    @pantry.add_to_cookbook(r3)

    assert_equal 3, @pantry.cookbook.length
  end

  def test_compare_stock_to_recipe
    r1 = Recipe.new("Cheese Pizza")
    r1.add_ingredient("Cheese", 20)
    r1.add_ingredient("Flour", 20)
    @pantry.restock("Cheese", 20)
    @pantry.restock("Flour", 20)

    assert @pantry.can_make?(r1)
  end

  def test_what_can_i_make
    skip
    r1 = Recipe.new("Cheese Pizza")
    r1.add_ingredient("Cheese", 20)
    r1.add_ingredient("Flour", 20)
    r2 = Recipe.new("Brine Shot")
    r2.add_ingredient("Brine", 10)
    r3 = Recipe.new("Peanuts")
    r3.add_ingredient("Raw nuts", 10)
    r3.add_ingredient("Salt", 10)
    @pantry.restock("Cheese", 10)
    @pantry.restock("Flour", 20)
    @pantry.restock("Brine", 40)
    @pantry.restock("Raw nuts", 20)
    @pantry.restock("Salt", 20)

    assert_equal ["Brine Shot", "Peanuts"], @pantry.what_can_i_make
  end
end

# pantry.restock("Cheese", 10)
# pantry.restock("Flour", 20)
# pantry.restock("Brine", 40)
# pantry.restock("Raw nuts", 20)
# pantry.restock("Salt", 20)
# # What can i make?
# pantry.what_can_i_make # => ["Brine Shot", "Peanuts"]
# # How many can i make?
# pantry.how_many_can_i_make # => {"Brine Shot" => 4, "Peanuts" => 2}
# ```
