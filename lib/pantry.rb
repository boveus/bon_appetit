class Pantry
  attr_reader  :stock
  def initialize
    @stock = {}
  end

  def stock_check(food)
    if @stock[food] == nil
      @stock[food] = 0
    end
    @stock[food]
  end

end
