require 'rails_helper'

RSpec.describe Cart, type: :model do
  it "works" do
    expect(1).to be 1
  end

  it "可以把商品丟到到購物車裡，然後購物車裡就有東西了" do
    cart = Cart.new

    cart.add(1)

    expect(cart.empty?).to be false
  end

  it "如果加了相同種類的商品到購物車裡，購買項目(CartItem)並不會增加，但商品的數量會改變" do
    cart = Cart.new

    3.times { cart.add(2) }
    2.times { cart.add(3) }
    3.times { cart.add(2) }

    expect(cart.items.count).to be 2
    expect(cart.items.last.quantity).to be 2
  end

  it "商品可以放到購物車裡，也可以再拿出來" do
    # p1 = Product.create(title: "P1", price: 10)
    # p1 = FactoryBot.create(:product)
    p1 = create(:product, price: 10)
    cart = Cart.new

    cart.add(p1.id)

    expect(cart.items.last.product).to be_kind_of Product
    # expect(cart.items.last.product).to be_a Product
  end

  it "可以計算整台購物車的總消費金額" do
    p1 = create(:product, price: 10)
    p2 = create(:product, price: 20)
    cart = Cart.new

    3.times { cart.add(p1.id) }
    5.times { cart.add(p2.id) }

    expect(cart.total_price).to be 130
  end

  it "聖誕節的時候全面打 9 折" do
    p1 = create(:product, price: 10)
    p2 = create(:product, price: 20)
    cart = Cart.new

    3.times { cart.add(p1.id) }
    5.times { cart.add(p2.id) }

    t = Time.local(Time.now.year, 12, 24, 0, 0, 0)
    Timecop.travel(t)

    expect(cart.total_price).to be 117
  
    Timecop.return
  end

  it "特別活動可搭配折扣（例如聖誕節的時候全面打 9 折，或是滿額滿千送百或滿額免運費）" do
    p1 = create(:product, price: 100)
    p2 = create(:product, price: 200)
    cart = Cart.new

    3.times { cart.add(p1.id) }
    5.times { cart.add(p2.id) }

    expect(cart.total_price).to be 1200
  end

  it "可以將購物車內容轉換成 Hash ，存到 Session 裡" do
    p1 = create(:product, price: 100)
    p2 = create(:product, price: 200)
    cart = Cart.new

    3.times { cart.add(p1.id) }
    2.times { cart.add(p2.id) }

    expect(cart.to_hash).to eq cart_hash
  end

  it "還原成購物車的內容" do
    cart = Cart.from_hash(cart_hash)

    expect(cart.items.first.product_id).to be 1
    expect(cart.items.last.quantity).to be 2
  end

  private

  def cart_hash
    result = {
      "items" => [
        {"product_id" => 1, "quantity" => 3},
        {"product_id" => 2, "quantity" => 2}
      ]
    }
  end
end
