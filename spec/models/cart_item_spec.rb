require 'rails_helper'

RSpec.describe CartItem, type: :model do
  it "每個 Cart Item 都可以計算它自己的金額（小計）" do
    p1 =create(:product, price: 10)
    cart = Cart.new

    3.times { cart.add(p1.id) }

    expect(cart.items.first.total_price).to be 30
  end
end
