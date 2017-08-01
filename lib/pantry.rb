class Pantry
  attr_reader  :stock,
               :cookbook
               
  def initialize
    @stock = {}
    @cookbook = []
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

  def convert_units(recipe)
    converted_units_hash = {}
    recipe.ingredients.each_key do |ingredient|
      units, quantity = get_unit_and_convert(recipe.ingredients[ingredient])
      converted_units_hash[ingredient] = {:quantity => quantity, :units => units}
    end
    converted_units_hash
  end

  def get_unit_and_convert(quantity)
    units = ''
    if quantity > 100
      units = "Centi-Units"
      quantity = quantity / 100
    elsif quantity < 1
      units = "Milli-Units"
      quantity = quantity * 1000
    else
      units = "Universal Units"
    end
    return units, quantity.to_i
  end

  def add_to_cookbook(recipe)
    @cookbook << recipe
  end
end
