class Checkout
  attr_reader :total

  def initialize
    @total = 0
    @list_products = []
  end

  def scan(product)
    @list_products << product
  end

  def get_current_quantity(product)
    @list_products.select { |p| p.code == product.code }.count
  end

  def total
    @list_products.uniq.sum do |p|
      quantity_to_pay = get_current_quantity(p)
      unit_price = p.price 

      # redefine the unit price if the quantity exceeds the minimum for a discount
      if p.min_reduc && quantity_to_pay >= p.min_reduc
        unit_price = p.new_price
      end

      # remove quantity to pay if the quantity exceed the quantity for a get_one_free
      if p.get_one_free && quantity_to_pay > p.get_one_free
        quantity_to_pay -= 1
      end

      quantity_to_pay * unit_price
    end
  end
end
