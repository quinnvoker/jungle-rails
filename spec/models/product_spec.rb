require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    it 'should save if all fields are valid' do
      category = Category.create(name: 'Telecommunications')
      product = Product.new(name: "Jet Radio", price: 10000, quantity: 39, category: category)
      product.save!
      expect(Product.find_by name: "Jet Radio").to eql(product)
    end

    it 'should fail to save without a name' do
      category = Category.create(name: 'Telecommunications')
      product = Product.new(price: 10000, quantity: 39, category: category)
      product.save

      name_error = product.errors.full_messages.include?("Name can't be blank")
      expect(name_error).to be(true)
    end

    it 'should fail to save without a price' do
      category = Category.create(name: 'Telecommunications')
      product = Product.new(name: "Jet Radio", quantity: 39, category: category)
      product.save
      
      price_error = product.errors.full_messages.include?("Price can't be blank")
      expect(price_error).to be(true)
    end

    it 'should fail to save without a quantity' do
      category = Category.create(name: 'Telecommunications')
      product = Product.new(name: "Jet Radio", price: 10000, category: category)
      product.save
      
      quantity_error = product.errors.full_messages.include?("Quantity can't be blank")
      expect(quantity_error).to be(true)
    end

    it 'should fail to save without a category' do
      product = Product.new(name: "Jet Radio", price: 10000, quantity: 39)
      product.save
      
      category_error = product.errors.full_messages.include?("Category can't be blank")
      expect(category_error).to be(true)
    end
  end
end
