require './lib/pantry'
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

end


### Iteration 1: Pantry Stocking
# Build a simple Pantry-tracking program that can store a list of ingredients and available
# quantities. Once we have tracked our ingredients and quantities, we'll use the Recipe class
# we built before to have the pantry check to see what we can make.
# Support the following interactions:
# ```ruby
# pantry = Pantry.new
# # => <Pantry...>
# # Checking and adding stock
# pantry.stock
# # => {}
# pantry.stock_check("Cheese")
# # => 0
# pantry.restock("Cheese", 10)
# pantry.stock_check("Cheese")
# # => 10
# pantry.restock("Cheese", 20)
# pantry.stock_check("Cheese")
# # => 30
# ```
