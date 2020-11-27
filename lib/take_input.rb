module TakeInput
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
