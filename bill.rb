require_relative "price_table"

class Bill
  attr_accessor :ordered_items
  attr_reader :total_amount, :saved_amount

  def initialize(ordered_items = [])
    @ordered_items = ordered_items
    @total_amount = 0
    @saved_amount = 0
    @items_quantity = @ordered_items.tally
    @price_list = PriceTable.new().price_list
  end

  def actual_amount
    total_amount_without_sale = @items_quantity.keys.inject(0) do |total, item|
      item_info = @price_list[item.to_sym]
      total += @items_quantity[item] * item_info[:unit_price]
    end
    total_amount_without_sale
  end

  def discounted_amount
    total_discounted_amount = @items_quantity.keys.inject(0) do |total, item|
      total += price_of_item(item)
    end
    total_discounted_amount
  end

  def price_of_item(item)
    item_info = @price_list[item.to_sym]
    if (item_info[:sale_quantity] >= 1)
      discounted_price = (@items_quantity[item] / item_info[:sale_quantity]) * item_info[:sale_price]
      price = (@items_quantity[item] % item_info[:sale_quantity]) * item_info[:unit_price]
      (discounted_price + price)
    else
      @items_quantity[item] * item_info[:unit_price]
    end
  end

  def saved_amount
    actual_amount - discounted_amount
  end

  def print_bill
    dotted_line = "\n----------------------------------------------\n"
    table_head = "\n\nItem\t\t Quantity  \t\tPrice"
    table_body = @items_quantity.keys.inject("") do |str, item|
      str += "#{item.capitalize}\t\t #{@items_quantity[item]}\t\t\t$#{price_of_item(item)}\n\n"
    end
    str = "#{table_head}#{dotted_line}#{table_body}\n"
    print str
    puts "Total price : $#{discounted_amount.round(2)}"
    puts "You saved $#{saved_amount.round(2)} today.\n\n"
  end
end
