class Pantry
  attr_reader  :stock
  def initialize
    @stock = {}
  end

  def stock_check(food)
    check_if_food_in_stock_hash(food)
    @stock[food]
  end

  def restock(food, amount)
    check_if_food_in_stock_hash(food)
    @stock[food] += 10
  end

  def check_if_food_in_stock_hash(food)
    if @stock[food] == nil
      @stock[food] = 0
    end
  end
end
