require_relative "price_table"
require_relative "bill"

class Cart
  attr_reader :orders

  def initialize
    @orders = []
  end

  def billing
    if (@orders.length > 0)
      bill = Bill.new(@orders)
      discounted_total_amount = bill.discounted_amount
      saved_amount = bill.saved_amount
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

  def take_input()
    puts "Please enter all the items purchased separated by a comma."
    user_input = gets.chomp!

    if (user_input.length > 0)
      parse_input_string(user_input)
    else
      puts "No order has been placed."
      take_input
    end
  end

  def parse_input_string(user_input)
    item_list = user_input.downcase.split(",").map { |item| item.gsub(/\s+/, "") }
    add_to_cart(item_list)
  end
end

cart = Cart.new

cart.take_input
