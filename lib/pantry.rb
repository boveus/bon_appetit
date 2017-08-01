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
    @stock[food] += amount
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

  def can_make?(recipe)
    truthy_array = []
    recipe.ingredients.each_key do |ingredient|
      required = recipe.ingredients[ingredient]
      on_hand = stock_check(ingredient)
      truthy_array << (required <= on_hand)
    end
    truthy_array.all?
  end


  def what_can_i_make
    can_make_array = []
    @cookbook.each do |recipe|
      if can_make?(recipe)
        can_make_array << recipe.name
      end
    end
    can_make_array
  end
end
