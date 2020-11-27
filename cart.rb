require_relative "price_table"
require_relative "bill"
require_relative "take_input"

class Cart
  include TakeInput
  attr_reader :orders

  def initialize
    @orders = []
  end

  def billing
    if (@orders.length > 0)
      bill = Bill.new(@orders)
      bill.print_bill
    else
      puts "No order has been placed."
    end
  end

  def add_to_cart(item_list)
    store = PriceTable.new()
    all_items = store.price_list.keys
    @orders, unavailable_items = item_list.partition { |item| all_items.include?(item.to_sym) }

    puts "\n#{unavailable_items.join(", ")} is unavailable now." if unavailable_items.length > 0

    billing
  end
end

cart = Cart.new
cart.take_input
