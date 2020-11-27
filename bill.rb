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

    puts "Actual price is = #{total_amount_without_sale}"
    total_amount_without_sale
  end

  def discounted_amount
    total_discounted_amount = @items_quantity.keys.inject(0) do |total, item|
      item_info = @price_list[item.to_sym]
      discounted_price = (@items_quantity[item] / item_info[:sale_quantity]) * item_info[:sale_price]
      price = (@items_quantity[item] % item_info[:sale_quantity]) * item_info[:unit_price]
      total += discounted_price + price
    end
    puts "Discounted price is = #{total_discounted_amount}"
    total_discounted_amount
  end

  def saved_amount
    puts "saved price is = #{actual_amount - discounted_amount}"
    actual_amount - discounted_amount
  end
end
