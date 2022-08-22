# frozen_string_literal: true

class CartItem
  attr_reader :product_id, :quantity

  def initialize(product_id, quantity = 1)
    @product_id = product_id
    @quantity = quantity
  end

  def increment(quantity)
    @quantity += quantity
  end

  def product
    Product.find(@product_id)
  end

  def total_price(item = self)
    item.quantity * item.product.price
  end
end
