class Order < ActiveRecord::Base

  belongs_to :user
  has_many :line_items

  monetize :total_cents, numericality: true

  validates :stripe_charge_id, presence: true

  after_create do |order|
    order.line_items.each do |item|
      new_quantity = item.product.quantity - item.quantity
      Product.find(item.product).update_column(:quantity, new_quantity)
    end
  end
end
