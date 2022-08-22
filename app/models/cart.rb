class Cart
  def initialize(items = [])
    @items = items
  end

  def to_hash
    items = @items.map { |item|
      {"product_id" => item.product_id,
      "quantity" => item.quantity}
    }

    {"items" => items}
  end

  def self.from_hash(hash = nil)
    items = []

    if hash.is_a?(Hash) && hash["items"]
      items = hash["items"].map do |item|
        CartItem.new(item["product_id"], item["quantity"])
      end
    end
    
    Cart.new(items)
  end

  def add(product_id, quantity = 1)
    found_item = @items.find do |item|
      item.product_id == product_id
    end

    if found_item
      found_item.increment(quantity)
    else
      @items << CartItem.new(product_id, quantity)
    end
  end
  
  def empty?
    @items.empty?
  end

  def items
    @items
  end

  def total_price
    # @items.reduce(0) do |memo, item|
    #   memo + item.total_price
    # end
    total = @items.sum(&:total_price)

    if is_Xmas?
      total = (total * 0.9).floor
    end

    if total > 1000
      total = total - 100
    end
    
    total
  end

  private

  def is_Xmas?
    Time.now.month == 12 && [24, 25].include?(Time.now.day)
  end
end
