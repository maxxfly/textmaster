require '../lib/checkout'
require '../lib/product'

RSpec.describe Checkout do

  let(:fruit_tea_product) { Product.new('FR1', 'Fruit tea', 3.11) }
  let(:apple_product)     { Product.new('AP1', 'Apple', 5.0) }
  let(:coffee_product)    { Product.new('CF1', 'Coffee', 11.23) }

  let(:checkout)          { Checkout.new }

  before do
    fruit_tea_product.define_get_one_free(1)
    apple_product.define_reduce(3, 4.5)
  end

  describe 'check config' do
    it 'check config' do
      expect(1).to eq 1
    end
  end

  describe 'with one free product and some other products' do
    it {
      checkout.scan(fruit_tea_product)
      checkout.scan(apple_product)
      checkout.scan(fruit_tea_product)
      checkout.scan(coffee_product)

      expect(checkout.get_current_quantity(fruit_tea_product)).to eql 2
      expect(checkout.get_current_quantity(apple_product)).to eql 1
      expect(checkout.get_current_quantity(coffee_product)).to eql 1

      # in the spec, the expected price is 22.25 but I think that it is an error in the spec
      expect(checkout.total).to eql 19.34 # 22.25
    }
  end

  describe 'with one free product only' do
    it {
      checkout.scan(fruit_tea_product)
      checkout.scan(fruit_tea_product)

      expect(checkout.get_current_quantity(fruit_tea_product)).to eql 2
      expect(checkout.get_current_quantity(apple_product)).to eql 0
      expect(checkout.get_current_quantity(coffee_product)).to eql 0

      expect(checkout.total).to eql 3.11
    }
  end

  describe 'with reduc by quantity' do
    it {
      checkout.scan(apple_product)
      checkout.scan(apple_product)
      checkout.scan(fruit_tea_product)
      checkout.scan(apple_product)

      expect(checkout.get_current_quantity(fruit_tea_product)).to eql 1
      expect(checkout.get_current_quantity(apple_product)).to eql 3
      expect(checkout.get_current_quantity(coffee_product)).to eql 0

      expect(checkout.total).to eql 16.61
    }
  end
end
