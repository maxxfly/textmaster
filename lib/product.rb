class Product
  attr_reader :code, :name, :price, :get_one_free, :min_reduc, :new_price

  def initialize(code, name, price)
    @code = code
    @name = name
    @price = price
  end

  def define_get_one_free(count_buy)
    @get_one_free = count_buy
  end

  def define_reduce(min_reduc, new_price)
    @min_reduc = min_reduc
    @new_price = new_price
  end

end
