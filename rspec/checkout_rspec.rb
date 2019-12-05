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
      checkout.scan('FR1')
      checkout.scan('AP1')
      checkout.scan('FR1')
      checkout.scan('CF1')

      expect(checkout.total).to eql 22.25
    }
  end

  describe 'with one free product only' do
    it {
      checkout.scan('FR1')
      checkout.scan('FR1')

      expect(checkout.total).to eql 3.11
    }
  end

  describe 'with reduc by quantity' do
    it {
      checkout.scan('AP1')
      checkout.scan('AP1')
      checkout.scan('FR1')
      checkout.scan('AP1')

      expect(checkout.total).to eql 16.61
    }
  end
end
