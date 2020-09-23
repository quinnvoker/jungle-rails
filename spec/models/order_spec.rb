require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'After creation' do

    before :each do
      @category = Category.create!(name: "Apparel")
      @product1 = Product.create!({
        name: "Shoe",
        price: 10,
        quantity: 10,
        category: @category
      })
      @product2 = Product.create!({
        name: "Shirt",
        price: 10,
        quantity: 15,
        category: @category
      })

      @product3 = Product.create!({
        name: "Tie",
        price: 10,
        quantity: 15,
        category: @category
      })
    end

    it 'deducts quantity from products based on their line item quantities' do
      @order = Order.new({
        email: "test@test.com",
        total_cents: 3000,
        stripe_charge_id: 1
      })

      @order.line_items.new({
        product: @product1,
        quantity: 1,
        item_price: @product1.price,
        total_price: @product1.price
      })

      @order.line_items.new({
        product: @product2,
        quantity: 2,
        item_price: @product2.price,
        total_price: @product2.price * 2
      })

      @order.save!

      @product1.reload
      @product2.reload

      expect(@product1.quantity).to eql(9)
      expect(@product2.quantity).to eql(13)
    end

    it 'does not deduct quantity from products that are not in the order' do
      @order = Order.new({
        email: "test@test.com",
        total_cents: 3000,
        stripe_charge_id: 1
      })

      @order.line_items.new({
        product: @product1,
        quantity: 1,
        item_price: @product1.price,
        total_price: @product1.price
      })

      @order.line_items.new({
        product: @product2,
        quantity: 2,
        item_price: @product2.price,
        total_price: @product2.price * 2
      })

      @order.save!

      @product1.reload
      @product2.reload

      expect(@product3.quantity).to eql(15)
    end
  end
end

