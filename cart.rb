require_relative "price_table"

class Cart
  attr_reader :orders

  def initialize
    @orders = []
  end

  def add_to_cart(item_list)
    store = PriceTable.new()
    all_items = store.price_list.keys
    @orders, unavailable_items = item_list.partition { |item| all_items.include?(item.to_sym) }

    puts "\n#{unavailable_items.join(", ")} is unavailable now." if unavailable_items.length > 0
  end

  def take_input()
    puts "Please enter all the items purchased separated by a comma."
    user_input = gets.chomp!

    if (!user_input.nil? && user_input.length > 0)
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
